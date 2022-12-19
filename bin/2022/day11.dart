import '../day.dart';
import '../utils/iterable_extensions.dart';

class Day11 extends Day {
  Day11() : super(11, 2022);

  @override
  bool runTestInput = false;

  @override
  String testInput = '''Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1''';

  // @override
  String testInput1 = '''''';

  Future<void> part1() async {
    var game = await parseData(20, false);
    print(game.monkeyBusiness);
  }

  Future<void> part2() async {
    var game = await parseData(10000, true);
    // game.monkies.forEach((m) => print(m));
    print(game.monkeyBusiness);
  }

  Future<Game> parseData(int rounds, bool tooWorried) async {
    var game = Game(me: Me(tooWorried: tooWorried));
    await for (String line in lines) {
      game.setup(line);
    }
    game.play(rounds);
    return game;
  }
}

class Game {
  List<Monkey> monkies = [];
  final Me me;
  int get mod => monkies.map((e) => int.parse(e.testValue)).multiply();

  Game({
    required this.me,
  });

  int get monkeyBusiness {
    monkies.sort((a, b) => b.inspectionCount.compareTo(a.inspectionCount));
    return monkies.take(2).map((e) => e.inspectionCount).multiply();
  }

  void setup(String input) {
    if (input.startsWith('Monkey')) {
      monkies.add(Monkey(id: monkies.length.toString()));
    } else if (input.startsWith('  Starting items')) {
      var pattern = RegExp(r'  Starting items: ([\d, ]+)+?');
      final match = pattern.firstMatch(input)!;
      var items = match[1]!.split(', ');
      monkies.last.items = items.map((e) => int.parse(e)).toList();
    } else if (input.startsWith('  Operation:')) {
      var pattern = RegExp(r'  Operation: new = old ([+*]+) ([old\d+]+)');
      final match = pattern.firstMatch(input)!;
      monkies.last.operation = match[1]!;
      monkies.last.operationValue = match[2]!;
    } else if (input.startsWith('  Test:')) {
      var pattern = RegExp(r'  Test: divisible by ([\d+]+)');
      final match = pattern.firstMatch(input)!;
      monkies.last.testValue = match[1]!;
    } else if (input.startsWith('    If true:')) {
      var pattern = RegExp(r'    If true: throw to monkey ([\d+]+)');
      final match = pattern.firstMatch(input)!;
      monkies.last.testTrueMonkey = match[1]!;
    } else if (input.startsWith('    If false:')) {
      var pattern = RegExp(r'    If false: throw to monkey ([\d+]+)');
      final match = pattern.firstMatch(input)!;
      monkies.last.testFalseMonkey = match[1]!;
    }
  }

  void play(int numberOfRounds) {
    for (var i = 0; i < numberOfRounds; i++) {
      // print(i);
      for (var monkey in monkies) {
        //print('Monkey ${monkey.id}:');
        for (var item in monkey.items) {
          if (me.tooWorried) {
            item = item % mod;
          }
          item = monkey.inspectItem(item);
          item = me.afterMonkeyInspection(item);
          var receiverMonkeyId = monkey.test(item);
          monkey.throwItem(
              item,
              monkies.firstWhere(
                (monkey) => monkey.id == receiverMonkeyId,
              ));
        }
        monkey.items.clear();
      }
    }
  }
}

class Me {
  bool tooWorried;
  Me({required this.tooWorried});
  int afterMonkeyInspection(int item) {
    //print(
    //  '    Monkey gets bored with item. Worry level is divided by 3 to ${item ~/ 3}.');
    return tooWorried ? item : item ~/ 3;
  }
}

class Monkey {
  final String id;
  List<int> items = [];
  String operation = '';
  String operationValue = '';
  String testValue = '';
  String testTrueMonkey = '';
  String testFalseMonkey = '';
  int inspectionCount = 0;
  Monkey({
    required this.id,
  });

  String test(int item) {
    var worryLevelOfItem = item;
    var value = int.parse(testValue);
    if (worryLevelOfItem % value == 0) {
      //print('    Current worry level is divisible by $value.');
      return testTrueMonkey;
    }
    //print('    Current worry level is not divisible by $value.');
    return testFalseMonkey;
  }

  int inspectItem(int item) {
    inspectionCount += 1;
    var value = item;

    //print('  Monkey inspects an item with a worry level of $item.');
    if (operationValue != 'old') {
      value = int.parse(operationValue);
    }
    switch (operation) {
      case '+':
        //print('    Worry level increases by $value to ${item + value}.');
        item += value;
        break;
      case '*':
        //print('    Worry level is multiplied by $value to ${item * value}.');
        item *= value;
        break;
    }
    return item;
  }

  void throwItem(int item, Monkey receiverMonkey) {
    //print(
    //  '    Item with worry level $item is thrown to monkey ${receiverMonkey.id}.');
    receiverMonkey.items.add(item);
  }

  @override
  String toString() {
    return 'Monkey $id inspected items $inspectionCount times.';
  }
}



// TIL
// Primes, Modular Arithmetic
// http://pi.math.cornell.edu/~mec/2003-2004/cryptography/diffiehellman/diffiehellman.html
// https://www.maths.ox.ac.uk/system/files/attachments/lecture2.pdf
// https://www.maths.ox.ac.uk/system/files/attachments/lecture1.pdf
// https://en.wikipedia.org/wiki/Chinese_remainder_theorem
