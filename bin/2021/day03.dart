import '../day.dart';

class Day03 extends Day {
  Day03() : super(3, 2021);

  Future<void> part1() async {
    var powerConsumption = 0;
    var gammaRate = 0;
    var epsilonRate = 0;
    var numberOfReadings = 0;
    var readingBitlength;
    var bits = <int, int>{};
    await for (String line in lines) {
      numberOfReadings++;
      readingBitlength = line.length;
      for (var i = 0; i < line.length; i++) {
        bits[i] = bits[i] == null
            ? int.parse(line[i])
            : bits[i]! + int.parse(line[i]);
      }
    }
    var gammaRateBinary = '';
    for (var i = 0; i < bits.keys.length; i++) {
      gammaRateBinary += bits[i]! > numberOfReadings / 2 ? '1' : '0';
    }
    gammaRate = int.parse('$gammaRateBinary', radix: 2);
    epsilonRate = gammaRate ^ ((1 << readingBitlength) - 1);

    powerConsumption = gammaRate * epsilonRate;
    print(powerConsumption);
  }

  Future<void> part2() async {
    var lifeSupport = 0;
    var oxygenRate = 0;
    var co2Rate = 0;
    var readings = <String>[];

    await for (String line in lines) {
      readings.add(line);
    }

    var oxygenRateResult = _findBitCriteria(readings, 0, true);
    var co2RateResult = _findBitCriteria(readings, 0, false);

    oxygenRate = int.parse('$oxygenRateResult', radix: 2);
    co2Rate = int.parse('$co2RateResult', radix: 2);

    lifeSupport = oxygenRate * co2Rate;
    print(lifeSupport);
  }

  String _findBitCriteria(
    List<String> readings,
    int sortCriteriaIndex,
    bool findMostCommon,
  ) {
    final sortingMap = <int, List<String>>{0: [], 1: []};
    for (var reading in readings) {
      if (reading[sortCriteriaIndex] == '1') {
        sortingMap[1]!.add(reading);
      } else {
        sortingMap[0]!.add(reading);
      }
    }
    final mostPopularReadingList = sortingMap[0]!.length > sortingMap[1]!.length
        ? sortingMap[findMostCommon ? 0 : 1]
        : sortingMap[findMostCommon ? 1 : 0];
    if (mostPopularReadingList!.length == 1) {
      return mostPopularReadingList.first;
    } else {
      sortCriteriaIndex++;
      return _findBitCriteria(
        mostPopularReadingList,
        sortCriteriaIndex,
        findMostCommon,
      );
    }
  }
}
