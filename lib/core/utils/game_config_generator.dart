import 'package:minesweeper_game/core/enums/game_state.dart';

/// Game configuration constants for different difficulty levels
class GameConfig {
  static const easyBoardSize = 8;
  static const mediumBoardSize = 12;
  static const hardBoardSize = 16;

  static const easyMines = 10;
  static const mediumMines = 30;
  static const hardMines = 60;
}

/// Returns board dimensions (width or height) based on game difficulty
int getBoardSize(GameState gameState) {
  switch (gameState) {
    case GameState.easy:
      return GameConfig.easyBoardSize;
    case GameState.medium:
      return GameConfig.mediumBoardSize;
    case GameState.hard:
      return GameConfig.hardBoardSize;
  }
}

/// Returns tile width for game board
int tileWidthGenerator(GameState gameState) => getBoardSize(gameState);

/// Returns tile height for game board
int tileHeightGenerator(GameState gameState) => getBoardSize(gameState);

/// Returns number of mines based on game difficulty
int tileMinesGenerator(GameState gameState) {
  switch (gameState) {
    case GameState.easy:
      return GameConfig.easyMines;
    case GameState.medium:
      return GameConfig.mediumMines;
    case GameState.hard:
      return GameConfig.hardMines;
  }
}
