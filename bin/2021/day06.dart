import '../day.dart';

class laternFish {}

class Day06 extends Day {
  Day06() : super(6, 2021);

  Future<void> part1() async {
    var fish = await parseData();
    print(fish.length);
  }

  Future<void> part2() async {
    var stringLines = await parseData();
    print(stringLines);
  }

  Future<List<int>> parseData() async {
    var fish = <int>[];
    await for (String line in lines) {
      var data = line.split(',').map((e) => int.parse(e)).toList();

      fish = data;
    }
    return fish;
  }
}
