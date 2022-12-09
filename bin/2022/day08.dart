import '../day.dart';

class Day08 extends Day {
  Day08() : super(8, 2022);

  Future<void> part1() async {
    var stringLines = await parseData();
    print(stringLines);
  }

  Future<void> part2() async {
    var stringLines = await parseData();
    print(stringLines);
  }

  Future<int> parseData() async {
    var treeGrid = TreeGrid();
    await for (String line in lines) {
      treeGrid.addRow(line);
    }
    // treeGrid.addRow('30373');
    // treeGrid.addRow('25512');
    // treeGrid.addRow('65332');
    // treeGrid.addRow('33549');
    // treeGrid.addRow('35390');
    //9237 too high
    //940 too low
    return treeGrid.visibleTrees();
  }
}

class TreeGrid {
  final List<List<int>> trees = [];

  void addRow(String line) {
    trees.add(line.split('').map((e) => int.parse(e)).toList());
  }

  int visibleTrees() {
    var visibleTrees = 0;
    var bestScenicScore = 0;

    for (var y = 1; y < trees.length - 1; y++) {
      for (var x = 1; x < trees[y].length - 1; x++) {
        final tree = trees[y][x];

        var treeScenicScoreUp = 0;
        var treeScenicScoreDown = 0;
        var treeScenicScoreRight = 0;
        var treeScenicScoreLeft = 0;

        var treeIsVisibleUp = false;
        var treeIsVisibleDown = false;
        var treeIsVisibleRight = false;
        var treeIsVisibleLeft = false;

        var y1 = y - 1;
        while (y1 > -1) {
          treeScenicScoreUp++;
          if (tree > trees[y1][x]) {
            treeIsVisibleUp = true;
          } else {
            treeIsVisibleUp = false;
            y1 = -1;
          }
          y1--;
        }

        y1 = y + 1;
        while (y1 < trees[y].length) {
          treeScenicScoreDown++;
          if (tree > trees[y1][x]) {
            treeIsVisibleDown = true;
          } else {
            treeIsVisibleDown = false;
            y1 = trees[y].length;
          }
          y1++;
        }

        var x1 = x - 1;
        while (x1 > -1) {
          treeScenicScoreLeft++;
          if (tree > trees[y][x1]) {
            treeIsVisibleLeft = true;
          } else {
            treeIsVisibleLeft = false;
            x1 = -1;
          }
          x1--;
        }

        x1 = x + 1;
        while (x1 < trees[y].length) {
          treeScenicScoreRight++;
          if (tree > trees[y][x1]) {
            treeIsVisibleRight = true;
          } else {
            treeIsVisibleRight = false;
            x1 = trees[y].length;
          }
          x1++;
        }
        if (treeIsVisibleUp ||
            treeIsVisibleDown ||
            treeIsVisibleLeft ||
            treeIsVisibleRight) {
          visibleTrees++;
        }

        var treeScenicScore = treeScenicScoreUp *
            treeScenicScoreDown *
            treeScenicScoreLeft *
            treeScenicScoreRight;

        if (treeScenicScore > bestScenicScore) {
          bestScenicScore = treeScenicScore;
        }

        print(
            '($x,$y) ($tree:$treeScenicScore) :⬆️:$treeIsVisibleUp ⬇️:$treeIsVisibleDown ⬅️:$treeIsVisibleLeft ➡️:$treeIsVisibleRight');
      }
    }

    final boundaryTrees = (trees.length * 2) +
        trees[0].length +
        trees[trees.length - 1].length -
        4;

    visibleTrees += boundaryTrees;

    print(bestScenicScore);

    return visibleTrees;
  }
}
