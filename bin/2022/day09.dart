import '../day.dart';
import '../utils/coordinate.dart';

class Day09 extends Day {
  Day09() : super(9, 2022);

  @override
  bool runTestInput = false;

  String testInput1 = '''R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2''';

  @override
  String testInput = '''R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20''';

  Future<void> part1() async {
    // var stringLines = await parseData(1);
    // print(stringLines);
  }

  Future<void> part2() async {
    var stringLines = await parseData(9);
    print(stringLines);
  }

  Future<int> parseData(int numberOfTails) async {
    var world = World(numberOfTails);
    await for (String line in lines) {
      world.Move(line);
    }
    return world.visitedTailPositions;
  }
}

class RopeKnot {
  @override
  String toString() {
    return '$position has moved ${positionLog.length}';
  }

  Coordinate position = Coordinate.zero;
  Set<Coordinate> positionLog = {Coordinate.zero};

  void trackAndSetPosition(Coordinate newPosition) {
    position = newPosition;
    positionLog.add(position);
  }
}

class World {
  final List<List<String>> grid = [];
  RopeKnot headOfRope = RopeKnot();
  Coordinate heading = Coordinate.zero;
  List<RopeKnot> knots = [];
  int get visitedTailPositions => knots.last.positionLog.length;

  World(int numberOfTails) {
    knots = List<RopeKnot>.generate(numberOfTails, (index) => RopeKnot());
  }

  void Move(String input) {
    final inputs = input.split(' ');
    final direction = inputs[0];
    final distance = int.parse(inputs[1]);

    _setHeading(direction, distance);
    _move(distance);
  }

  void _setHeading(String direction, int distance) {
    switch (direction) {
      case 'U':
        heading.y += distance;
        break;
      case 'D':
        heading.y -= distance;
        break;
      case 'L':
        heading.x -= distance;
        break;
      case 'R':
        heading.x += distance;
        break;
    }
  }

  void _move(steps) {
    for (var i = 0; i < steps; i++) {
      _moveRope(heading, headOfRope);
      for (var i = 0; i < knots.length; i++) {
        var knot = knots[i];
        var isKnotChild = knots.length > 1 && i >= 1;
        var parent = isKnotChild ? knots[i - 1] : headOfRope;

        if (knot.position.within(1, parent.position)) {
          continue;
        }

        _moveRope(parent.position, knot);
      }
    }
  }

  void _moveRope(
    Coordinate newPosition,
    RopeKnot knot,
  ) {
    var newKnotPosition = knot.position.copy;
    if (newPosition.x > knot.position.x) {
      newKnotPosition.addX(1);
    } else {
      if (newPosition.x < knot.position.x) {
        newKnotPosition.addX(-1);
      }
    }

    if (newPosition.y > knot.position.y) {
      newKnotPosition.addY(1);
    } else if (newPosition.y < knot.position.y) {
      newKnotPosition.addY(-1);
    }
    knot.trackAndSetPosition(newKnotPosition);
  }
}
