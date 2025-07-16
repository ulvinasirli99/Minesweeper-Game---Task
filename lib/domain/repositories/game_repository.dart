import '../entities/game_board.dart';

abstract class GameRepository {
  GameBoard createNewGame(int width, int height, int mineCount);
  GameBoard revealTile(int x, int y);
  GameBoard toggleFlag(int x, int y);
  GameBoard updateTimer();
  GameBoard getCurrentBoard();
} 