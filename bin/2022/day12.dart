import '../day.dart';
import '../utils/consts.dart';
import '../utils/string_extensions.dart';

class Day12 extends Day {
  Day12() : super(12, 2022);

  @override
  bool runTestInput = true;

  @override
  String testInput = '''Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi''';

  Future<void> part1() async {
    var stringLines = await parseData();
    print(stringLines);
  }

  Future<void> part2() async {
    var stringLines = await parseData();
    print(stringLines);
  }

  Future<Map> parseData() async {
    final world = Map();
    await for (String line in lines) {
      world.setup(line);
    }
    return world;
  }
}

class Map {
  List<String> get characters => lowerCaseAToZ;
  List<List<String>> map = [];

  void setup(String row) {
    map.add(row.splitChars());
  }
}
