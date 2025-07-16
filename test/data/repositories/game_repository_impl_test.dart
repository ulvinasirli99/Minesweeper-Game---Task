import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper_game/data/repositories/game_repository_impl.dart';
import 'package:minesweeper_game/domain/entities/game_board.dart';

void main() {
  late GameRepositoryImpl repository;

  setUp(() {
    repository = GameRepositoryImpl();
  });

  group('GameRepositoryImpl', () {
    test('createNewGame should create a board with correct dimensions', () {
      final board = repository.createNewGame(8, 8, 10);

      expect(board.width, equals(8));
      expect(board.height, equals(8));
      expect(board.mineCount, equals(10));
      expect(board.status, equals(GameStatus.playing));
      expect(board.flagCount, equals(0));
      expect(board.elapsedSeconds, equals(0));
    });

    test('createNewGame should place correct number of mines', () {
      final board = repository.createNewGame(8, 8, 10);
      var mineCount = 0;

      for (var row in board.tiles) {
        for (var tile in row) {
          if (tile.hasMine) mineCount++;
        }
      }

      expect(mineCount, equals(10));
    });

    test('createNewGame should calculate adjacent mines correctly', () {
      final board = repository.createNewGame(3, 3, 1);
      var mineLocation = const Point(-1, -1);

      // Find the mine location
      for (var y = 0; y < board.height; y++) {
        for (var x = 0; x < board.width; x++) {
          if (board.tiles[y][x].hasMine) {
            mineLocation = Point(x, y);
            break;
          }
        }
      }

      // Check adjacent tiles
      for (var y = 0; y < board.height; y++) {
        for (var x = 0; x < board.width; x++) {
          if (!board.tiles[y][x].hasMine) {
            final dx = (x - mineLocation.x).abs();
            final dy = (y - mineLocation.y).abs();
            final isAdjacent = dx <= 1 && dy <= 1 && !(dx == 0 && dy == 0);
            final expectedCount = isAdjacent ? 1 : 0;
            expect(board.tiles[y][x].adjacentMines, equals(expectedCount),
                reason: 'Tile at ($x, $y) should have $expectedCount adjacent mines');
          }
        }
      }
    });

    test('revealTile should reveal empty tiles and their neighbors', () {
      final board = repository.createNewGame(8, 8, 10);
      var safeX = -1;
      var safeY = -1;

      // Find a safe tile with no adjacent mines
      for (var y = 0; y < board.height; y++) {
        for (var x = 0; x < board.width; x++) {
          if (!board.tiles[y][x].hasMine && board.tiles[y][x].adjacentMines == 0) {
            safeX = x;
            safeY = y;
            break;
          }
        }
        if (safeX != -1) break;
      }

      if (safeX != -1) {
        final newBoard = repository.revealTile(safeX, safeY);
        var revealedCount = 0;

        for (var row in newBoard.tiles) {
          for (var tile in row) {
            if (tile.isRevealed) revealedCount++;
          }
        }

        // Should reveal more than one tile due to flood fill
        expect(revealedCount, greaterThan(1));
      }
    });

    test('revealTile should end game when mine is revealed', () {
      final board = repository.createNewGame(8, 8, 10);
      var mineX = -1;
      var mineY = -1;

      // Find a mine
      for (var y = 0; y < board.height; y++) {
        for (var x = 0; x < board.width; x++) {
          if (board.tiles[y][x].hasMine) {
            mineX = x;
            mineY = y;
            break;
          }
        }
        if (mineX != -1) break;
      }

      final newBoard = repository.revealTile(mineX, mineY);
      expect(newBoard.status, equals(GameStatus.lost));
    });

    test('toggleFlag should increment and decrement flag count', () {
      final board = repository.createNewGame(8, 8, 10);
      final x = 0;
      final y = 0;

      final flaggedBoard = repository.toggleFlag(x, y);
      expect(flaggedBoard.flagCount, equals(1));
      expect(flaggedBoard.tiles[y][x].isFlagged, isTrue);

      final unflaggedBoard = repository.toggleFlag(x, y);
      expect(unflaggedBoard.flagCount, equals(0));
      expect(unflaggedBoard.tiles[y][x].isFlagged, isFalse);
    });

    test('updateTimer should increment elapsed seconds', () {
      repository.createNewGame(8, 8, 10);
      final updatedBoard = repository.updateTimer();
      expect(updatedBoard.elapsedSeconds, equals(1));
    });

    test('getCurrentBoard should throw when game not initialized', () {
      expect(() => repository.getCurrentBoard(), throwsException);
    });
  });
}

class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);
} 