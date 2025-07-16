class Tile {
  final int x;
  final int y;
  final bool hasMine;
  final bool isRevealed;
  final bool isFlagged;
  final int adjacentMines;

  const Tile({
    required this.x,
    required this.y,
    required this.hasMine,
    required this.isRevealed,
    required this.isFlagged,
    required this.adjacentMines,
  });

  Tile copyWith({
    bool? hasMine,
    bool? isRevealed,
    bool? isFlagged,
    int? adjacentMines,
  }) {
    return Tile(
      x: x,
      y: y,
      hasMine: hasMine ?? this.hasMine,
      isRevealed: isRevealed ?? this.isRevealed,
      isFlagged: isFlagged ?? this.isFlagged,
      adjacentMines: adjacentMines ?? this.adjacentMines,
    );
  }
} 