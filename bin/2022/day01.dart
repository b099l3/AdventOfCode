import '../day.dart';

class Day01 extends Day {
  Day01() : super(1, 2022);

  Future<void> part1() async {
    var output = await parseLinesForElfCalories();
    print('Part 1: ${output.last}');
  }

  Future<void> part2() async {
    var output = await parseLinesForTop3ElfCalories();
    print('Part 2: $output');
  }

  Future<List<int>> parseLinesForElfCalories() async {
    var elfs = <int>[];
    var calories = 0;
    await for (String line in lines) {
      if (line != '') {
        calories += int.parse(line);
      } else {
        elfs.add(calories);
        calories = 0;
      }
    }
    elfs.sort();
    return elfs;
  }

  Future<int> parseLinesForTop3ElfCalories() async {
    var elfs = await parseLinesForElfCalories();
    final elfsReversed = elfs.reversed;
    return elfsReversed.take(3).reduce((a, b) => a + b);
  }
}
