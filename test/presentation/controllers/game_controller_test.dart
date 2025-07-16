import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper_game/domain/entities/game_board.dart';
import 'package:minesweeper_game/domain/entities/tile.dart';
import 'package:minesweeper_game/domain/repositories/game_repository.dart';
import 'package:minesweeper_game/domain/usecases/create_game.dart';
import 'package:minesweeper_game/domain/usecases/reveal_tile.dart';
import 'package:minesweeper_game/domain/usecases/toggle_flag.dart';
import 'package:minesweeper_game/presentation/controllers/game_controller.dart';

class MockGameRepository implements GameRepository {
  GameBoard? _board;

  @override
  GameBoard createNewGame(int width, int height, int mineCount) {
    _board = GameBoard(
      tiles: List.generate(
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
      ),
      width: width,
      height: height,
      mineCount: mineCount,
      status: GameStatus.playing,
      flagCount: 0,
      elapsedSeconds: 0,
    );
    return _board!;
  }

  @override
  GameBoard getCurrentBoard() {
    if (_board == null) throw Exception('Game not initialized');
    return _board!;
  }

  @override
  GameBoard revealTile(int x, int y) {
    if (_board == null) throw Exception('Game not initialized');
    final tiles = List.of(_board!.tiles.map((row) => List.of(row)));
    tiles[y][x] = tiles[y][x].copyWith(isRevealed: true);
    _board = _board!.copyWith(tiles: tiles);
    return _board!;
  }

  @override
  GameBoard toggleFlag(int x, int y) {
    if (_board == null) throw Exception('Game not initialized');
    final tiles = List.of(_board!.tiles.map((row) => List.of(row)));
    final tile = tiles[y][x];
    tiles[y][x] = tile.copyWith(isFlagged: !tile.isFlagged);
    _board = _board!.copyWith(
      tiles: tiles,
      flagCount: _board!.flagCount + (tile.isFlagged ? -1 : 1),
    );
    return _board!;
  }

  @override
  GameBoard updateTimer() {
    if (_board == null) throw Exception('Game not initialized');
    _board = _board!.copyWith(elapsedSeconds: _board!.elapsedSeconds + 1);
    return _board!;
  }
}

void main() {
  late GameController controller;
  late MockGameRepository mockRepository;

  setUp(() {
    mockRepository = MockGameRepository();
    controller = GameController(
      createGame: CreateGame(mockRepository),
      revealTile: RevealTile(mockRepository),
      toggleFlag: ToggleFlag(mockRepository),
    );
  });

  group('GameController', () {
    test('initial state should be null', () {
      expect(controller.isGameInitialized, isFalse);
      expect(controller.boardNotifier.value, isNull);
    });

    test('startNewGame should initialize the game', () {
      controller.startNewGame(8, 8, 10);

      expect(controller.isGameInitialized, isTrue);
      expect(controller.boardNotifier.value, isNotNull);
      expect(controller.boardNotifier.value!.width, equals(8));
      expect(controller.boardNotifier.value!.height, equals(8));
      expect(controller.boardNotifier.value!.mineCount, equals(10));
    });

    test('revealTile should update board state', () {
      controller.startNewGame(8, 8, 10);
      controller.revealTile(0, 0);

      expect(controller.boardNotifier.value!.tiles[0][0].isRevealed, isTrue);
    });

    test('toggleFlag should update board state', () {
      controller.startNewGame(8, 8, 10);
      controller.toggleFlag(0, 0);

      expect(controller.boardNotifier.value!.tiles[0][0].isFlagged, isTrue);
      expect(controller.boardNotifier.value!.flagCount, equals(1));

      controller.toggleFlag(0, 0);
      expect(controller.boardNotifier.value!.tiles[0][0].isFlagged, isFalse);
      expect(controller.boardNotifier.value!.flagCount, equals(0));
    });

    test('timer should increment elapsed seconds', () async {
      controller.startNewGame(8, 8, 10);
      final initialSeconds = controller.boardNotifier.value!.elapsedSeconds;

      // Wait for timer to tick
      await Future.delayed(const Duration(seconds: 2));

      expect(
        controller.boardNotifier.value!.elapsedSeconds,
        greaterThan(initialSeconds),
      );
    });
  });
} 