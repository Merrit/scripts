import 'dart:io';

Future<void> main(List<String> args) async {
  await runBashCommand(
    '''gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <2>}]"''',
  );

  await runBashCommand(
    'gsettings set org.gnome.desktop.interface scaling-factor 2',
  );

  await runBashCommand('autorandr --load main');
}

Future<void> runBashCommand(String command) async {
  await Process.run('bash', [
    '-c',
    command,
  ]);
}
