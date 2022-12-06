import '../day.dart';

class Day06 extends Day {
  Day06() : super(6, 2022);

  Future<void> part1() async {
    var stringLines = await parseData(4);
    print(stringLines);
  }

  Future<void> part2() async {
    var stringLines = await parseData(14);
    print(stringLines);
  }

  Future<int> parseData(int windowSize) async {
    await for (String line in lines) {
      final list = <String>[];
      var data = line.split('');
      for (var i = 0; i < data.length; i++) {
        final newChar = data[i];
        if (list.length == windowSize) {
          list.removeAt(0);
        }
        list.add(newChar);

        if (list.length == windowSize) {
          var seen = <String>{};
          final uniquelist = list.where((char) => seen.add(char)).toList();

          if (uniquelist.length == list.length) {
            return i + 1;
          }
        }
      }
    }
    return -1;
  }
}
