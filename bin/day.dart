import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'secrets.dart';

class Day {
  Stream<String> lines = Stream.empty();
  int year;

  Day(int dayNumber, this.year) {
    lines = remoteFile(dayNumber);

    // I was manually copying the input but thats lame.
    //lines = localFile(dayNumber);
  }

  Stream<String> remoteFile(int dayNumber) {
    final url =
        Uri.parse('https://adventofcode.com/$year/day/$dayNumber/input');

    final response = http
        .get(url, headers: {'Cookie': 'session=$code'})
        .asStream()
        .map((response) => response.body)
        .transform(LineSplitter());
    return response;
  }

  Stream<String> localFile(int dayNumber) {
    final dayNumberPadded = dayNumber.toString().padLeft(2, '0');
    return File('./input/day$dayNumberPadded.txt')
        .openRead()
        .transform(utf8.decoder)
        .transform(LineSplitter());
  }
}
