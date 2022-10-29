import 'dart:io';

class Sink {
  static const speakers = 'alsa_output.pci-0000_2d_00.4.analog-stereo';
  static const tv = 'alsa_output.pci-0000_2b_00.1.hdmi-stereo-extra3';
}

late final bool shouldToggleMute;
late final bool targetingTV;
late final String sink;
late final int volumeStep;

Future<void> main(List<String> args) async {
  shouldToggleMute = args.contains('mute');
  targetingTV = args.contains('tv');
  sink = (targetingTV) ? Sink.tv : Sink.speakers;
  volumeStep = (targetingTV) ? 5 : 2;

  if (args.contains('mute')) await toggleMute();
  if (args.contains('up')) await changeVolume('up');
  if (args.contains('down')) await changeVolume('down');
}

Future<void> toggleMute() async {
  await runCommand('pactl set-sink-mute $sink toggle');
  await notify();
}

// Location of the `i3-volume` application.
const i3volume = '/home/merritt/Applications/i3-volume/volume';

Future<void> changeVolume(String direction) async {
  final volume = await getVolume();

  // Don't go past 100% volume.
  if (volume == 100 && direction == 'up') return;

  await runCommand('$i3volume -s $sink "$direction" $volumeStep');
  await notify();
}

Future<int> getVolume() async {
  // Get the volume as a percent (eg 60%).
  final result = await runCommand('$i3volume -s $sink output %v');

  final volumePercent = result.stdout as String;
  if (volumePercent == 'MUTE') return 0;

  return int.parse(volumePercent.substring(0, volumePercent.length - 1));
}

Future<void> notify() async {
  final int volume = await getVolume();
  final double volumeDouble = volume / 100;

  final icon = (volume == 0) ? 'audio-volume-muted' : 'audio-volume-medium';

  final target = (targetingTV) ? 'TV' : 'Speakers';

  // Disable this check for now, because the DBus version works much better.
  // Keeping it around because I believe the next version of GNOME has
  // dropped this DBus method and we will need an alternative..
  // Don't forget that creating an OSD via Flutter is an option!
  // if [ $targetingTV = true ] ; then
  if (true) {
    // Trigger GNOME's OSD via DBUS.
    await runCommand(
      "gdbus call --session --dest org.gnome.Shell --object-path /codes/merritt/OSDInterface --method codes.merritt.OSDInterface.showOSD $icon '$target volume: $volume' $volumeDouble 1",
      // 'gdbus call --session --dest "org.gnome.Shell" --object-path "/org/gnome/Shell" --method "org.gnome.Shell.ShowOSD" "{\'icon\': <\'$icon\'>, \'label\': <\'$target volume: $volume\'>, \'level\': <$volumeDouble>}"',
    );
  }
  // else {
  // const _notificationsId="audio-script";
  //   // Send generic notification (works with GNOME) that the volume has changed to trigger notification.
  //   //     _notificationsId=$(/home/merritt/.local/bin/notify-send.py \
  //   //         "Volume" "$volume" \
  //   //         --hint string:image-path:$icon \
  //   //         boolean:transient:true \
  //   //         --replaces-process $_notificationsId)
  // }

  // Send notification to Plasma that the volume has changed to trigger OSD.
  // qdbus-qt5 org.kde.plasmashell /org/kde/osdService volumeChanged $volume
  // Alternate notification option:
  // kdialog --title "Pulseaudio" --passivepopup "Toggled PC Speaker Mute" 1 &
}

Future<ProcessResult> runCommand(String command) async {
  final result = await Process.run('bash', ['-c', command]);
  print(result.stderr);
  return result;
}
