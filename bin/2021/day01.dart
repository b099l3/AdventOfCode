import '../day.dart';

class Day01 extends Day {
  Day01() : super(1, 2021);

  Future<void> part1() async {
    var previousMeasurement = 0;
    var countOfIncreases = 0;
    await for (var line in lines) {
      var measurement = int.parse(line);
      if (previousMeasurement > 0 && measurement > previousMeasurement) {
        countOfIncreases++;
      }
      previousMeasurement = measurement;
    }
    print(countOfIncreases);
  }

  Future<void> part2() async {
    var measurements = [-1, -1, -1];
    var countOfIncreases = 0;
    await for (var line in lines) {
      var measurement = int.parse(line);
      if (measurements[0] >= 0 && measurement > measurements[0]) {
        countOfIncreases++;
      }
      measurements = [measurements[1], measurements[2], measurement];
    }
    print(countOfIncreases);
  }
}
