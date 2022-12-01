import '../day.dart';

class Coord {
  int x, y;
  Coord(this.x, this.y);

  @override
  String toString() => '[$x,$y]';
}

class ThermalLine {
  Coord pointA;
  Coord pointB;
  List<Coord> coordsCovered = [];
  ThermalLine(this.pointA, this.pointB) {
    coordsCovered = _getCoordsCovered();
  }

  bool get _isHorizontal => pointA.x == pointB.x;
  bool get _isVertical => pointA.y == pointB.y;
  bool get IsValidLine => _isHorizontal || _isVertical;

  @override
  String toString() => '[${pointA.x},${pointA.y}],[${pointB.x},${pointB.y}],';

  List<Coord> _getCoordsCovered() {
    // a[1,3] b[3,1]
    // a[1,3] b[3,1] c[2,2]
    var covered = <Coord>[pointA, pointB];
    var refPoint = Coord(pointA.x, pointA.y);
    while (refPoint.x != pointB.x || refPoint.y != pointB.y) {
      var newPoint = Coord(refPoint.x, refPoint.y);

      if (pointA.x < pointB.x) {
        newPoint.x++;
      } else if (pointA.x > pointB.x) {
        newPoint.x--;
      }

      if (pointA.y < pointB.y) {
        newPoint.y++;
      } else if (pointA.y > pointB.y) {
        newPoint.y--;
      }

      if (newPoint.x != pointB.x || newPoint.y != pointB.y) {
        covered.add(newPoint);
      }
      refPoint = newPoint;
    }

    return covered;
  }
}

class WorldMap {
  final _map = List.generate(
    1000,
    (_) => List.generate(1000, (_) => 0),
  );
  WorldMap();

  void ApplyThermalLine(ThermalLine line) {
    for (var coord in line.coordsCovered) {
      _map[coord.x][coord.y] += 1;
    }
  }

  int get numberOfOverlaps => _map
      .expand((row) => row)
      .map((point) => point >= 2 ? 1 : 0)
      .reduce((value, e) => value + e);
}

class Day05 extends Day {
  Day05() : super(5, 2021);

  Future<void> part1() async {
    var thermalLines = await parseData();
    var worldMap = WorldMap();

    for (var thermalLine in thermalLines) {
      if (thermalLine.IsValidLine) {
        worldMap.ApplyThermalLine(thermalLine);
      }
    }

    print(worldMap.numberOfOverlaps);
  }

  Future<void> part2() async {
    var thermalLines = await parseData();
    var worldMap = WorldMap();

    for (var thermalLine in thermalLines) {
      worldMap.ApplyThermalLine(thermalLine);
    }

    print(worldMap.numberOfOverlaps);
  }

  Future<List<ThermalLine>> parseData() async {
    var thermalLines = <ThermalLine>[];
    await for (String line in lines) {
      var data = line
          .split(' -> ')
          .map((coords) => coords.split(','))
          .expand((point) => point)
          .map((e) => int.parse(e))
          .toList();

      thermalLines.add(ThermalLine(
        Coord(data[0], data[1]),
        Coord(data[2], data[3]),
      ));
    }
    return thermalLines;
  }
}
