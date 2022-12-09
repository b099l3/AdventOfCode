class Coordinate {
  int x, y;
  Coordinate(this.x, this.y);

  static Coordinate get zero => Coordinate(0, 0);
  Coordinate get copy => Coordinate(x, y);

  @override
  String toString() => '[$x,$y]';

  @override
  bool operator ==(other) {
    if (other is! Coordinate) {
      return false;
    }
    return other.x == x && other.y == y;
  }

  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  Coordinate addX(int dx) {
    x += dx;
    return this;
  }

  Coordinate addY(int dy) {
    y += dy;
    return this;
  }

  bool within(int distance, Coordinate other) {
    if (this == other) return true;

    var test = other.x - distance <= x &&
        other.x + distance >= x &&
        other.y - distance <= y &&
        other.y + distance >= y;
    return test;
  }
}
