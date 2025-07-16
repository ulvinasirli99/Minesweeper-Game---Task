import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper_game/core/constant/app_string_constant.dart';
import 'package:minesweeper_game/domain/entities/game_board.dart';
import 'package:minesweeper_game/domain/entities/tile.dart';
import 'package:minesweeper_game/domain/repositories/game_repository.dart';
import 'package:minesweeper_game/domain/usecases/create_game.dart';
import 'package:minesweeper_game/domain/usecases/reveal_tile.dart';
import 'package:minesweeper_game/domain/usecases/toggle_flag.dart';
import 'package:minesweeper_game/presentation/controllers/game_controller.dart';
import 'package:minesweeper_game/presentation/screens/game_screen.dart';
import 'package:minesweeper_game/presentation/widgets/game_board_widget.dart';

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

  testWidgets('GameScreen shows loading state when board is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: GameScreen(controller: controller),
      ),
    );

    expect(find.text(loadingText), findsOneWidget);
    expect(find.text(appName), findsOneWidget);
  });

  testWidgets('GameScreen shows game board when game is started',
      (WidgetTester tester) async {
    controller.startNewGame(8, 8, 10);
    
    await tester.pumpWidget(
      MaterialApp(
        home: GameScreen(controller: controller),
      ),
    );

    expect(find.text(loadingText), findsNothing);
    expect(find.byType(GameBoardWidget), findsOneWidget);
  });

  testWidgets('GameScreen shows game info when game is started',
      (WidgetTester tester) async {
    controller.startNewGame(8, 8, 10);
    
    await tester.pumpWidget(
      MaterialApp(
        home: GameScreen(controller: controller),
      ),
    );

    expect(find.text(minesText), findsOneWidget);
    expect(find.text(timeText), findsOneWidget);
  });

  testWidgets('GameScreen updates mine count when flagging tiles',
      (WidgetTester tester) async {
    controller.startNewGame(8, 8, 10);
    
    await tester.pumpWidget(
      MaterialApp(
        home: GameScreen(controller: controller),
      ),
    );

    final initialMineCount = find.textContaining('10').evaluate().single.widget as Text;
    expect(initialMineCount.data, equals('10'));

    // Long press a tile to flag it
    await tester.longPress(find.byType(GestureDetector).first);
    await tester.pump();

    final updatedMineCount = find.textContaining('9').evaluate().single.widget as Text;
    expect(updatedMineCount.data, equals('9'));
  });

  testWidgets('GameScreen shows restart button when game is over',
      (WidgetTester tester) async {
    controller.startNewGame(8, 8, 10);
    final board = controller.boardNotifier.value!;
    
    // Simulate game over by revealing a mine
    final mineX = 0;
    final mineY = 0;
    controller.boardNotifier.value = board.copyWith(
      tiles: List.generate(
        board.height,
        (y) => List.generate(
          board.width,
          (x) => x == mineX && y == mineY
              ? Tile(
                  x: x,
                  y: y,
                  hasMine: true,
                  isRevealed: true,
                  isFlagged: false,
                  adjacentMines: 0,
                )
              : board.tiles[y][x],
        ),
      ),
      status: GameStatus.lost,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: GameScreen(controller: controller),
      ),
    );

    expect(find.byTooltip(restartGameTooltip), findsOneWidget);
  });
} 