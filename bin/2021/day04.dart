import 'package:collection/collection.dart';

import '../day.dart';

class BingoNumber {
  BingoNumber(this.number);
  int number;
  bool drawn = false;
}

class Board {
  int id;
  bool hasWon = false;
  List<List<BingoNumber>> numbers = [];
  Board(this.id);

  bool checkForWin(int drawnNumber) {
    if (hasWon) {
      return hasWon;
    }
    for (var row = 0; row < numbers.length; row++) {
      for (var col = 0; col < numbers[row].length; col++) {
        if (numbers[row][col].number == drawnNumber) {
          numbers[row][col].drawn = true;
          // print('board $id has a match for $drawnNumber');
        }
      }
    }

    // check for win
    // horizontal
    for (var row = 0; row < numbers.length; row++) {
      var checkWin = false;
      for (var col = 0; col < numbers[row].length; col++) {
        checkWin = numbers[row][col].drawn;
        if (!checkWin) break;
      }
      if (checkWin) {
        return true;
      }
    }
    //vertical
    for (var col = 0; col < numbers[0].length; col++) {
      var checkWin = false;
      for (var row = 0; row < numbers.length; row++) {
        checkWin = numbers[row][col].drawn;
        if (!checkWin) break;
      }
      if (checkWin) {
        return true;
      }
    }
    return hasWon;
  }

  int sumUnCheckedNumbers() {
    return numbers
        .expand((row) => row)
        .where((bingoNumber) => !bingoNumber.drawn)
        .map((bn) => bn.number)
        .sum;
  }

  void addRow(List<int> row) =>
      numbers.add(row.map((n) => BingoNumber(n)).toList());
}

class Day04 extends Day {
  Day04() : super(4, 2021);

  Future<void> part1() async {
    var drawNumbers = <int>[];
    var boards = <Board>[];
    var index = -1;
    await for (String line in lines) {
      if (drawNumbers.isEmpty) {
        if (line == '') continue;
        drawNumbers = line.split(',').map((n) => int.parse(n)).toList();
      } else {
        if (line == '') {
          index++;
          boards.add(Board(index));
          continue;
        } else {
          boards[index].addRow(
            line
                .trimLeft()
                .split(RegExp(r'\s+'))
                .skipWhile((v) => v.isEmpty)
                .map((n) => int.parse(n))
                .toList(),
          );
        }
      }
    }

    Board? winningBoard;
    var winningNumber = 0;

    for (var number in drawNumbers) {
      // print('drawn: $number');
      break;
      for (var board in boards) {
        var win = board.checkForWin(number);
        if (win) {
          winningNumber = number;
          winningBoard = board;
          board.hasWon = true;
          break;
        }
      }
    }

    if (winningBoard == null) {
      // print('No winner');
      return;
    }
    final score = winningBoard.sumUnCheckedNumbers() * winningNumber;
    print(score);
  }

  Future<void> part2() async {
    var drawNumbers = <int>[];
    var boards = <Board>[];
    var index = -1;
    await for (String line in lines) {
      if (drawNumbers.isEmpty) {
        if (line == '') continue;
        drawNumbers = line.split(',').map((n) => int.parse(n)).toList();
      } else {
        if (line == '') {
          index++;
          boards.add(Board(index));
          continue;
        } else {
          boards[index].addRow(
            line
                .trimLeft()
                .split(RegExp(r'\s+'))
                .skipWhile((v) => v.isEmpty)
                .map((n) => int.parse(n))
                .toList(),
          );
        }
      }
    }

    Board? winningBoard;
    var winningNumber = 0;

    for (var number in drawNumbers) {
      // print('drawn: $number');
      if (boards.any((board) => board.hasWon == false)) {
        for (var board in boards) {
          if (board.hasWon) continue;
          var win = board.checkForWin(number);
          if (win) {
            winningNumber = number;
            winningBoard = board;
            board.hasWon = true;
          }
        }
      } else {
        break;
      }
    }

    if (winningBoard == null) {
      // print('No winner');
      return;
    }
    final score = winningBoard.sumUnCheckedNumbers() * winningNumber;
    print(score);
  }
}
