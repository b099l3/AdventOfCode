List<String> get lowerCaseAToZ {
  var aCode = 'a'.codeUnitAt(0);
  var zCode = 'z'.codeUnitAt(0);
  var alphabets = List<String>.generate(
    zCode - aCode + 1,
    (index) => String.fromCharCode(aCode + index),
  );
  return alphabets;
}
