import '../day.dart';

class Day02 extends Day {
  Day02() : super(2, 2021);

  Future<void> part1() async {
    var depth = 0;
    var horizontalPos = 0;
    await for (String line in lines) {
      final lineParts = line.split(' ');
      var movement = int.parse(lineParts[1]);
      switch (lineParts[0]) {
        case 'up':
          depth -= movement;
          break;
        case 'down':
          depth += movement;
          break;
        case 'forward':
          horizontalPos += movement;
          break;
      }
    }
    print(depth * horizontalPos);
  }

  Future<void> part2() async {
    var depth = 0;
    var horizontalPos = 0;
    var aim = 0;
    await for (String line in lines) {
      final lineParts = line.split(' ');
      var movement = int.parse(lineParts[1]);
      switch (lineParts[0]) {
        case 'up':
          aim -= movement;
          break;
        case 'down':
          aim += movement;
          break;
        case 'forward':
          horizontalPos += movement;
          depth += movement * aim;
          break;
      }
    }
    print(depth * horizontalPos);
  }
}
