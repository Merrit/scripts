import 'dart:io';

Future<void> main(List<String> args) async {
  await runBashCommand(
    '''gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <1>}]"''',
  );

  await runBashCommand(
    'gsettings set org.gnome.desktop.interface scaling-factor 1',
  );

  await runBashCommand('autorandr --load tv');
}

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

/* Move window, when TV is not being mirrored.
import 'dart:io';

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    print('No arguments were passed.');
    exit(0);
  }

  final shouldMove = args.contains('move');
  final shouldFullscreen = args.contains('fullscreen');

  var command = 'sleep 5;';

  if (shouldMove) {
    command += 'xdotool getactivewindow windowmove --sync 5520 0;';
  }

  if (shouldFullscreen) {
    command += 'wmctrl -r :ACTIVE: -b toggle,fullscreen;';
  }

  await Process.run('bash', ['-c', command]);
}
 */