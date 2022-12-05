import '../day.dart';

class Day05 extends Day {
  Day05() : super(5, 2022);

  Future<void> part1() async {
    var stringLines = await parseData();
    print(stringLines);
  }

  Future<void> part2() async {
    var stringLines = await parseData(isCrateMover9001: true);
    print(stringLines);
  }

  Future<String> parseData({isCrateMover9001 = false}) async {
    var readyForMovesInput = false;
    final dock = Dock(isCrateMover9001);
    await for (String line in lines) {
      if (line.startsWith(' 1')) continue;
      if (line == '') {
        readyForMovesInput = true;
        continue;
      }

      if (readyForMovesInput) {
        dock.runProcedure(line);
      } else {
        dock.CrateInput(line);
      }
    }
    // FPHFQPQWT
    return dock.getTopOfStacks();
  }
}

class Dock {
  final List<List<String>> stacks = List.generate(9, (_) => []);
  final bool isCrateMover9001;

  Dock(this.isCrateMover9001);

  void CrateInput(String input) {
    final stacksInput = input.split('');

    var start = 0;
    var ref = 4;
    for (var i = 0; i < stacks.length; i++) {
      final stackValue = stacksInput.skip(start).take(ref).toList()[1];
      if (stackValue != ' ') {
        stacks[i].add(stackValue);
      }
      start += ref;
    }
  }

  String getTopOfStacks() =>
      stacks.map((stack) => stack.first).reduce((a, b) => a + b);

  void runProcedure(String input) {
    var exp = RegExp(r'move (\d+) from (\d+) to (\d+)');
    final stacksInstructions = exp.allMatches(input).expand((m) sync* {
      yield int.parse(m[1]!);
      yield int.parse(m[2]!);
      yield int.parse(m[3]!);
    }).toList();
    final stacksToMove = stacksInstructions[0];
    final fromStack = stacks[stacksInstructions[1] - 1];
    final toStack = stacks[stacksInstructions[2] - 1];

    if (fromStack.isEmpty) {
      return;
    }

    var stacksFrom = fromStack.take(stacksToMove);
    if (!isCrateMover9001) {
      stacksFrom = stacksFrom.toList().reversed;
    }
    toStack.insertAll(0, stacksFrom);
    for (var i = 0; i < stacksToMove; i++) {
      fromStack.removeAt(0);
    }
  }
}
