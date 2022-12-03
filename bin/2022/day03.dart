import '../day.dart';

class Day03 extends Day {
  Day03() : super(3, 2022);

  final points = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  Future<void> part1() async {
    var totalPoints = 0;
    await for (String rucksack in lines) {
      var comp1 = rucksack.substring(0, rucksack.length ~/ 2);
      var comp2 = rucksack.substring(rucksack.length ~/ 2);
      var dupes = <int>[];
      comp1.runes.forEach((item) {
        if (comp2.runes.contains(item)) {
          dupes.add(item);
        }
      });

      totalPoints +=
          points.indexWhere((letter) => letter.runes.first == dupes.first) + 1;
    }
    print(totalPoints);
  }

  Future<void> part2() async {
    var stringLines = await parseData();
    print(stringLines);
  }

  Future<int> parseData() async {
    var totalPoints = 0;
    var threeElves = <String>[];
    await for (String rucksack in lines) {
      threeElves.add(rucksack);
      if (threeElves.length != 3) {
        continue;
      }

      var dupes = <int>[];
      threeElves[0].runes.forEach((item) {
        if (threeElves[1].runes.contains(item)) {
          if (threeElves[2].runes.contains(item)) {
            dupes.add(item);
          }
        }
      });

      totalPoints +=
          points.indexWhere((letter) => letter.runes.first == dupes.first) + 1;
      threeElves.clear();
    }
    return totalPoints;
  }
}


// Learnings
// Never knew about 
// - runes on a string, to show Unicode code-points of a String
// - Truncating division operator ~/
// Performs truncating division of this number by [other]. Truncating division is division where a fractional result is converted to an integer by rounding towards zero.
