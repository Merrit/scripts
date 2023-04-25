import 'dart:io';

Future<void> main(List<String> args) async {
  await runBashCommand(
    '''gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <1>}]"''',
  );

  await runBashCommand(
    'gsettings set org.gnome.desktop.interface scaling-factor 1',
  );

  await runBashCommand(
    'gsettings set org.gnome.desktop.interface text-scaling-factor 1.4',
  );

  await runBashCommand(
    'xrandr --output DisplayPort-0 --off --output DisplayPort-1 --off --output HDMI-A-0 --off --output HDMI-A-1 --primary --mode 3840x2160 --scale 1x1 --primary --set TearFree on --pos 0x0 --rotate normal --output DVI-D-0 --off',
  );
}

/// Runs a bash command and prints the result.
Future<void> runBashCommand(String command) async {
  final result = await Process.run('bash', [
    '-c',
    command,
  ]);

  print('''
Finished running command: $command

stderr: ${result.stderr}

stdout: ${result.stdout}
''');
}
