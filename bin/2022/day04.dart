import '../day.dart';

class Day04 extends Day {
  Day04() : super(4, 2022);

  Future<void> part1() async {
    var count = 0;
    await for (String patterns in lines) {
      final elfPatterns = patterns.split(',');
      final rangeFirst =
          elfPatterns[0].split('-').map((e) => int.parse(e)).toList();
      final rangeSec =
          elfPatterns[1].split('-').map((e) => int.parse(e)).toList();

      if (rangeFirst[0] >= rangeSec[0] && rangeFirst[1] <= rangeSec[1]) {
        count++;
      } else if (rangeSec[0] >= rangeFirst[0] && rangeSec[1] <= rangeFirst[1]) {
        count++;
      }
    }
    print(count);
  }

  Future<void> part2() async {
    var stringLines = await parseData();
    print(stringLines);
  }

  Future<int> parseData() async {
    //lines.map((line) => line.split(',').map((elf) => elf.split('-'))).map((event) => null);

    var count = 0;
    await for (String patterns in lines) {
      final elfPatterns = patterns.split(',');
      final rangeFirst =
          elfPatterns[0].split('-').map((e) => int.parse(e)).toList();
      final rangeSec =
          elfPatterns[1].split('-').map((e) => int.parse(e)).toList();

      if (rangeFirst[0] >= rangeSec[0] &&
          rangeSec[1] <= rangeFirst[1] &&
          rangeFirst[0] <= rangeSec[1]) {
        count++;
      } else if (rangeFirst[0] < rangeSec[0] && rangeFirst[1] >= rangeSec[0]) {
        count++;
      } else if (rangeFirst[0] >= rangeSec[0] && rangeFirst[1] <= rangeSec[1]) {
        count++;
      } else if (rangeSec[0] >= rangeFirst[0] && rangeSec[1] <= rangeFirst[1]) {
        count++;
      }
    }
    return count;
  }
}
