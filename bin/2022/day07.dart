import '../day.dart';

class Day07 extends Day {
  Day07() : super(7, 2022);

  var fileSystem = FileSystem();

  Future<void> part1() async {
    await parseData();
    final size = fileSystem.findTotalSizeForDirectoriesUnder(100000);
    print(size);
  }

  Future<void> part2() async {
    await parseData();
    final size = fileSystem.findSmallestDirectoryToDeleteForUpdate();
    print(size);
  }

  Future<void> parseData() async {
    await for (String line in lines) {
      if (line.startsWith('\$')) {
        final commandParts = line.split(' ');
        final parameter = commandParts.length == 3 ? commandParts[2] : null;
        final command = commandParts[1];
        fileSystem.runCommand(command, parameter);
      } else {
        if (line.startsWith('dir')) {
          final fileParts = line.split(' ');
          final file = Directory(
              name: fileParts[1], parent: fileSystem.currentDirectory);
          fileSystem.add(file);
        } else {
          final fileParts = line.split(' ');
          final file = File(name: fileParts[1], size: int.parse(fileParts[0]));
          fileSystem.add(file);
        }
      }
    }
  }
}

class FileSystem {
  final List<Directory> contents = [Directory(name: '/')];
  Directory? currentDirectory;
  int totalSpace = 70000000;
  int updateSpace = 30000000;

  void add(File file) {
    currentDirectory!.contents.add(file);
  }

  void runCommand(String command, String? params) {
    switch (command) {
      case 'ls':
        break;
      case 'cd':
        if (params == '..' && currentDirectory!.parent != null) {
          currentDirectory = currentDirectory!.parent;
        } else if (currentDirectory == null) {
          currentDirectory = contents
              .whereType<Directory>()
              .firstWhere((dir) => dir.name == params);
        } else if (currentDirectory!.contents
            .any((dir) => dir.name == params)) {
          currentDirectory = currentDirectory!.contents
              .whereType<Directory>()
              .firstWhere((dir) => dir.name == params);
        } else {
          print('No Directory called - $params');
        }
        break;
    }
  }

  int findTotalSizeForDirectoriesUnder(int minSize) {
    return recurseDirs(contents.first, minSize);
  }

  int findSmallestDirectoryToDeleteForUpdate() {
    final usedSpace = getTotalUsedSize();
    final spaceLeft = totalSpace - usedSpace;
    final spaceToFreeUpForUpgrade = updateSpace - spaceLeft;
    final smallestDirectoryToDelete =
        findSmallestDirectoryToDeleteFor(spaceToFreeUpForUpgrade);
    return smallestDirectoryToDelete;
  }

  int getTotalUsedSize() {
    return recurseFiles(contents.first, totalSpace);
  }

  int findSmallestDirectoryToDeleteFor(int spaceToFreeUpForUpgrade) {
    findDirToDelete(contents.first, spaceToFreeUpForUpgrade);
    if (candidatesToDelete.isEmpty) return -1;
    candidatesToDelete.sort();
    return candidatesToDelete.first;
  }

  List<int> candidatesToDelete = [];
  int findDirToDelete(Directory directory, int sizeToDelete) {
    var sizeOfDir = 0;
    for (var dir in directory.contents.whereType<Directory>()) {
      if (dir.contents.whereType<Directory>().isNotEmpty) {
        sizeOfDir += findDirToDelete(dir, sizeToDelete);
      }
      sizeOfDir = dir.getSize();
      if (sizeOfDir >= sizeToDelete) {
        print('${dir.name} could be deleted to free up $sizeOfDir');
        candidatesToDelete.add(sizeOfDir);
      }
    }
    return sizeOfDir;
  }

  int recurseFiles(Directory directory, int minSize) {
    var size = 0;
    for (var dir in directory.contents.whereType<Directory>()) {
      if (dir.contents.whereType<Directory>().isNotEmpty) {
        size += recurseFiles(dir, minSize);
      }
      final sizeOfDir = dir.getOnlyFilesSize();
      size += sizeOfDir;
    }
    return size;
  }

  int recurseDirs(Directory directory, int minSize) {
    var size = 0;
    for (var dir in directory.contents.whereType<Directory>()) {
      if (dir.contents.whereType<Directory>().isNotEmpty) {
        size += recurseDirs(dir, minSize);
      }
      final sizeOfDir = dir.getSize();
      if (sizeOfDir <= minSize) {
        size += sizeOfDir;
      }
    }
    return size;
  }
}

class Directory extends File {
  final Directory? parent;
  final List<File> contents = [];
  Directory({required super.name, this.parent});

  @override
  int getSize() {
    final size = contents.isEmpty
        ? 0
        : contents
            .whereType<File>()
            .map((e) => e.getSize())
            .reduce((size1, size2) => size1 + size2);
    return size;
  }

  int getOnlyFilesSize() {
    final size = contents.where((element) => element is! Directory).isEmpty
        ? 0
        : contents
            .where((element) => element is! Directory)
            .map((e) => e.getSize())
            .reduce((size1, size2) => size1 + size2);
    return size;
  }
}

class File {
  final String name;
  final int size;
  File({required this.name, this.size = 0});

  int getSize() => size;
}
