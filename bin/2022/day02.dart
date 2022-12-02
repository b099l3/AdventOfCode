import '../day.dart';

enum RPS {
  rock('A', 'X', 1),
  paper('B', 'Y', 2),
  scissors('C', 'Z', 3);

  const RPS(this.op, this.me, this.points);
  final String op;
  final String me;
  final int points;

  static RPS getRPSFromCode(String code) {
    if (code == RPS.rock.op || code == RPS.rock.me) {
      return RPS.rock;
    } else if (code == RPS.paper.op || code == RPS.paper.me) {
      return RPS.paper;
    } else if (code == RPS.scissors.op || code == RPS.scissors.me) {
      return RPS.scissors;
    }
    throw Exception('not valid code $code');
  }
}

enum Result {
  lost('X', 0),
  draw('Y', 3),
  win('Z', 6);

  const Result(this.me, this.points);
  final String me;
  final int points;

  static Result getResultFromCode(String code) {
    if (code == Result.lost.me) {
      return Result.lost;
    } else if (code == Result.draw.me) {
      return Result.draw;
    } else if (code == Result.win.me) {
      return Result.win;
    }
    throw Exception('not valid code $code');
  }
}

class Day02 extends Day {
  Day02() : super(2, 2022);

  Future<void> part1() async {
    var stringLines = await parseData();
    print(stringLines);
  }

  Future<void> part2() async {
    var stringLines = await parseData(determinedOutcome: true);
    print(stringLines);
  }

  Future<int> parseData({bool determinedOutcome = false}) async {
    var totalPoints = 0;
    await for (String line in lines) {
      final round = line.split(' ');
      final opponent = round[0];
      final me = round[1];
      final points = determinedOutcome
          ? playWithDetermindOutcome(opponent, me)
          : play(opponent, me);
      totalPoints += points;
    }
    return totalPoints;
  }

  int play(String opp, String me) {
    final opHand = RPS.getRPSFromCode(opp);
    final meHand = RPS.getRPSFromCode(me);

    if (opHand == meHand) {
      return Result.draw.points + meHand.points;
    }

    if (opHand == RPS.rock && meHand == RPS.paper) {
      return Result.win.points + meHand.points;
    }
    if (opHand == RPS.paper && meHand == RPS.scissors) {
      return Result.win.points + meHand.points;
    }
    if (opHand == RPS.scissors && meHand == RPS.rock) {
      return Result.win.points + meHand.points;
    }
    return Result.lost.points + meHand.points;
  }

  int playWithDetermindOutcome(String opp, String result) {
    final opHand = RPS.getRPSFromCode(opp);
    final determinedResult = Result.getResultFromCode(result);

    if (determinedResult == Result.win) {
      switch (opHand) {
        case RPS.rock:
          return Result.win.points + RPS.paper.points;
        case RPS.paper:
          return Result.win.points + RPS.scissors.points;
        case RPS.scissors:
          return Result.win.points + RPS.rock.points;
      }
    }

    if (determinedResult == Result.lost) {
      switch (opHand) {
        case RPS.rock:
          return Result.lost.points + RPS.scissors.points;
        case RPS.paper:
          return Result.lost.points + RPS.rock.points;
        case RPS.scissors:
          return Result.lost.points + RPS.paper.points;
      }
    }

    return Result.draw.points + opHand.points;
  }
}
