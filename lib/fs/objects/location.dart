class Location {
  static const zero = Location(0, 0);

  const Location(this.x, this.y);

  final int x;
  final int y;

  Location operator +(Location other) => Location(x + other.x, y + other.y);
  Location operator -(Location other) => Location(x - other.x, y - other.y);

  @override
  String toString() => '($x, $y)';

  @override
  bool operator ==(Object other) =>
      other is Location && //
      x == other.x &&
      y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}
