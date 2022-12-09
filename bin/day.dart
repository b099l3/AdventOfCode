import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'secrets.dart';

abstract class Day {
  Stream<String> lines = Stream.empty();

  String testInput = '';
  bool runTestInput = false;

  Day(int dayNumber, year) {
    final dayNumberPadded = dayNumber.toString().padLeft(2, '0');
    final filePath = './input/$year/day$dayNumberPadded.txt';

    if (runTestInput) {
      lines = Stream.fromIterable(testInput.split('\n'));
    } else if (File(filePath).existsSync()) {
      lines = localFile(year, dayNumber, filePath);
    } else {
      lines = remoteFile(year, dayNumber, filePath);
    }
  }

  Stream<String> remoteFile(int year, int dayNumber, String filePath) {
    final url =
        Uri.parse('https://adventofcode.com/$year/day/$dayNumber/input');

    final file = File(filePath);
    file.createSync(recursive: true);
    final response = http
        .get(url, headers: {'Cookie': 'session=$code'})
        .asStream()
        .map((response) => response.body)
        .map((body) {
          file.writeAsStringSync(body);
          return body;
        })
        .transform(LineSplitter());

    return response;
  }

  Stream<String> localFile(int year, int dayNumber, String filePath) {
    return File(filePath)
        .openRead()
        .transform(utf8.decoder)
        .transform(LineSplitter());
  }
}
