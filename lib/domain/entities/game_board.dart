import 'tile.dart';

enum GameStatus {
  playing,
  won,
  lost
}

class GameBoard {
  final List<List<Tile>> tiles;
  final int width;
  final int height;
  final int mineCount;
  final GameStatus status;
  final int flagCount;
  final int elapsedSeconds;

  const GameBoard({
    required this.tiles,
    required this.width,
    required this.height,
    required this.mineCount,
    required this.status,
    required this.flagCount,
    required this.elapsedSeconds,
  });

  GameBoard copyWith({
    List<List<Tile>>? tiles,
    GameStatus? status,
    int? flagCount,
    int? elapsedSeconds,
  }) {
    return GameBoard(
      tiles: tiles ?? this.tiles,
      width: width,
      height: height,
      mineCount: mineCount,
      status: status ?? this.status,
      flagCount: flagCount ?? this.flagCount,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    );
  }

  bool get isGameOver => status == GameStatus.won || status == GameStatus.lost;
} 