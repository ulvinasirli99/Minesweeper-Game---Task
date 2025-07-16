import 'dart:math';
import '../../domain/entities/game_board.dart';
import '../../domain/entities/tile.dart';
import '../../domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  GameBoard? _currentBoard;

  @override
  GameBoard createNewGame(int width, int height, int mineCount) {
    final tiles = List.generate(
      height,
      (y) => List.generate(
        width,
        (x) => Tile(
          x: x,
          y: y,
          hasMine: false,
          isRevealed: false,
          isFlagged: false,
          adjacentMines: 0,
        ),
      ),
    );

    // Place mines randomly
    final random = Random();
    var remainingMines = mineCount;
    while (remainingMines > 0) {
      final x = random.nextInt(width);
      final y = random.nextInt(height);
      if (!tiles[y][x].hasMine) {
        tiles[y][x] = tiles[y][x].copyWith(hasMine: true);
        remainingMines--;
      }
    }

    // Calculate adjacent mines
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        if (!tiles[y][x].hasMine) {
          var count = 0;
          for (var dy = -1; dy <= 1; dy++) {
            for (var dx = -1; dx <= 1; dx++) {
              final newY = y + dy;
              final newX = x + dx;
              if (newY >= 0 && newY < height && newX >= 0 && newX < width) {
                if (tiles[newY][newX].hasMine) count++;
              }
            }
          }
          tiles[y][x] = tiles[y][x].copyWith(adjacentMines: count);
        }
      }
    }

    _currentBoard = GameBoard(
      tiles: tiles,
      width: width,
      height: height,
      mineCount: mineCount,
      status: GameStatus.playing,
      flagCount: 0,
      elapsedSeconds: 0,
    );

    return _currentBoard!;
  }

  @override
  GameBoard revealTile(int x, int y) {
    if (_currentBoard == null) throw Exception('Game not initialized');
    if (_currentBoard!.isGameOver) return _currentBoard!;

    final tiles = List.of(_currentBoard!.tiles.map((row) => List.of(row)));
    final tile = tiles[y][x];

    if (tile.isFlagged || tile.isRevealed) return _currentBoard!;

    if (tile.hasMine) {
      // Game over - reveal all mines
      for (var row in tiles) {
        for (var t in row) {
          if (t.hasMine) {
            row[t.x] = t.copyWith(isRevealed: true);
          }
        }
      }
      _currentBoard = _currentBoard!.copyWith(
        tiles: tiles,
        status: GameStatus.lost,
        elapsedSeconds: _currentBoard!.elapsedSeconds, // Preserve the elapsed time
      );
      return _currentBoard!;
    }

    // Reveal the tile and its neighbors if it has no adjacent mines
    _revealTileAndNeighbors(x, y, tiles);

    // Check for win
    var allNonMinesRevealed = true;
    for (var row in tiles) {
      for (var t in row) {
        if (!t.hasMine && !t.isRevealed) {
          allNonMinesRevealed = false;
          break;
        }
      }
    }

    _currentBoard = _currentBoard!.copyWith(
      tiles: tiles,
      status: allNonMinesRevealed ? GameStatus.won : GameStatus.playing,
      elapsedSeconds: _currentBoard!.elapsedSeconds, // Preserve the elapsed time
    );

    return _currentBoard!;
  }

  void _revealTileAndNeighbors(int x, int y, List<List<Tile>> tiles) {
    if (x < 0 || x >= _currentBoard!.width || y < 0 || y >= _currentBoard!.height) return;

    final tile = tiles[y][x];
    if (tile.isRevealed || tile.isFlagged || tile.hasMine) return;

    tiles[y][x] = tile.copyWith(isRevealed: true);

    if (tile.adjacentMines == 0) {
      for (var dy = -1; dy <= 1; dy++) {
        for (var dx = -1; dx <= 1; dx++) {
          if (dx == 0 && dy == 0) continue;
          _revealTileAndNeighbors(x + dx, y + dy, tiles);
        }
      }
    }
  }

  @override
  GameBoard toggleFlag(int x, int y) {
    if (_currentBoard == null) throw Exception('Game not initialized');
    if (_currentBoard!.isGameOver) return _currentBoard!;

    final tiles = List.of(_currentBoard!.tiles.map((row) => List.of(row)));
    final tile = tiles[y][x];

    if (tile.isRevealed) return _currentBoard!;

    // Check if we're trying to place more flags than mines
    if (!tile.isFlagged && _currentBoard!.flagCount >= _currentBoard!.mineCount) {
      return _currentBoard!;
    }

    final newFlagCount = _currentBoard!.flagCount + (tile.isFlagged ? -1 : 1);
    tiles[y][x] = tile.copyWith(isFlagged: !tile.isFlagged);

    _currentBoard = _currentBoard!.copyWith(
      tiles: tiles,
      flagCount: newFlagCount,
      elapsedSeconds: _currentBoard!.elapsedSeconds, // Preserve the elapsed time
    );

    return _currentBoard!;
  }

  @override
  GameBoard updateTimer() {
    if (_currentBoard == null) throw Exception('Game not initialized');
    if (_currentBoard!.isGameOver) return _currentBoard!;

    _currentBoard = _currentBoard!.copyWith(
      elapsedSeconds: _currentBoard!.elapsedSeconds + 1,
    );

    return _currentBoard!;
  }

  @override
  GameBoard getCurrentBoard() {
    if (_currentBoard == null) throw Exception('Game not initialized');
    return _currentBoard!;
  }
} 