import '../day.dart';

class Day10 extends Day {
  Day10() : super(10, 2022);

  @override
  bool runTestInput = false;

//   @override
//   String testInput1 = '''noop
// addx 3
// addx -5''';

  @override
  String testInput = '''addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop''';

  Future<void> part1() async {
    var device = await parseData();
    print(device.signalStrength);
  }

  Future<void> part2() async {
    var device = await parseData();
    print(device.display);
  }

  Future<Device> parseData() async {
    var device = Device();
    await for (String command in lines) {
      device.run(command);
    }
    return device;
  }
}

class Device {
  int registerX = 1;
  int cycle = 1;
  int signalStrength = 0;
  Command cmd = Command(cycleDuration: 0);
  int spritePosition = 0;
  String display = '';

  void run(String command) {
    var commandVariables = command.split(' ');
    var instruction = commandVariables[0];

    switch (instruction) {
      case 'noop':
        cmd = Command(
          cycleDuration: 1,
        );
        break;
      case 'addx':
        var parameter = int.parse(commandVariables[1]);
        //print('Start cycle\t$cycle: Begin executing addx $parameter');
        cmd = Command(
            cycleDuration: 2,
            command: () {
              registerX += parameter;
              spritePosition += parameter;
            });
        break;
    }
    while (cmd.cycleDuration != 0) {
      _runCycle();
    }
  }

  void _runCycle() {
    //print('During cycle\t$cycle: CRT draws pixel in position ${cycle - 1}');
    _drawPixel(position: cycle - 1);
    //print('Current CRT row: $display');
    cycle++;
    cmd.cycleDuration--;
    _runCommand();
    gatherSignalStrength();
  }

  void _runCommand() {
    if (cmd.cycleDuration == 0) {
      cmd.command?.call();
    }
  }

  void _drawPixel({required int position}) {
    var adjustedPosition = position;

    if (position % 40 == 0 && position != 0) {
      display += '\n';
    }
    if (position > 39) {
      adjustedPosition = position % 40;
    }
    if (adjustedPosition == spritePosition ||
        adjustedPosition == spritePosition + 1 ||
        adjustedPosition == spritePosition + 2) {
      display += '#';
    } else {
      display += '.';
    }
  }

  void gatherSignalStrength() {
    if (cycle == 20 ||
        cycle == 60 ||
        cycle == 100 ||
        cycle == 140 ||
        cycle == 180 ||
        cycle == 220) {
      var t = cycle * registerX;
      signalStrength += t;
      // print(
      // 'signal strength measure at cycle: $cycle : $registerX - $t ($signalStrength)');
    }
  }
}

class Command {
  int cycleDuration;
  Function? command;
  Command({
    required this.cycleDuration,
    this.command,
  });
}
