import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper_game/core/constant/app_icons.dart';
import 'package:minesweeper_game/domain/entities/game_board.dart';
import 'package:minesweeper_game/domain/entities/tile.dart';
import 'package:minesweeper_game/presentation/widgets/bomb_icon.dart';
import 'package:minesweeper_game/presentation/widgets/game_board_widget.dart';

void main() {
  late GameBoard board;

  setUp(() {
    board = GameBoard(
      tiles: List.generate(
        3,
        (y) => List.generate(
          3,
          (x) => Tile(
            x: x,
            y: y,
            hasMine: x == 1 && y == 1,
            isRevealed: false,
            isFlagged: false,
            adjacentMines: x == 0 && y == 0 ? 1 : 0,
          ),
        ),
      ),
      width: 3,
      height: 3,
      mineCount: 1,
      status: GameStatus.playing,
      flagCount: 0,
      elapsedSeconds: 0,
    );
  });

  testWidgets('GameBoardWidget displays correct number of tiles',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GameBoardWidget(
            board: board,
            onTileTap: (_, __) {},
            onTileLongPress: (_, __) {},
          ),
        ),
      ),
    );

    // Should find 9 tiles (3x3 grid)
    expect(find.byType(GestureDetector), findsNWidgets(9));
  });

  testWidgets('GameBoardWidget handles tap events', (WidgetTester tester) async {
    var tappedX = -1;
    var tappedY = -1;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GameBoardWidget(
            board: board,
            onTileTap: (x, y) {
              tappedX = x;
              tappedY = y;
            },
            onTileLongPress: (_, __) {},
          ),
        ),
      ),
    );

    // Tap the first tile
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump();

    expect(tappedX, equals(0));
    expect(tappedY, equals(0));
  });

  testWidgets('GameBoardWidget handles long press events',
      (WidgetTester tester) async {
    var longPressedX = -1;
    var longPressedY = -1;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GameBoardWidget(
            board: board,
            onTileTap: (_, __) {},
            onTileLongPress: (x, y) {
              longPressedX = x;
              longPressedY = y;
            },
          ),
        ),
      ),
    );

    // Long press the first tile
    await tester.longPress(find.byType(GestureDetector).first);
    await tester.pump();

    expect(longPressedX, equals(0));
    expect(longPressedY, equals(0));
  });

  testWidgets('GameBoardWidget displays flag when tile is flagged',
      (WidgetTester tester) async {
    final flaggedBoard = GameBoard(
      tiles: List.generate(
        3,
        (y) => List.generate(
          3,
          (x) => Tile(
            x: x,
            y: y,
            hasMine: false,
            isRevealed: false,
            isFlagged: x == 0 && y == 0,
            adjacentMines: 0,
          ),
        ),
      ),
      width: 3,
      height: 3,
      mineCount: 1,
      status: GameStatus.playing,
      flagCount: 1,
      elapsedSeconds: 0,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GameBoardWidget(
            board: flaggedBoard,
            onTileTap: (_, __) {},
            onTileLongPress: (_, __) {},
          ),
        ),
      ),
    );

    expect(find.byIcon(AppIcons.flag), findsOneWidget);
  });

  testWidgets('GameBoardWidget displays bomb when mine is revealed',
      (WidgetTester tester) async {
    final revealedBoard = GameBoard(
      tiles: List.generate(
        3,
        (y) => List.generate(
          3,
          (x) => Tile(
            x: x,
            y: y,
            hasMine: x == 1 && y == 1,
            isRevealed: x == 1 && y == 1,
            isFlagged: false,
            adjacentMines: 0,
          ),
        ),
      ),
      width: 3,
      height: 3,
      mineCount: 1,
      status: GameStatus.lost,
      flagCount: 0,
      elapsedSeconds: 0,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GameBoardWidget(
            board: revealedBoard,
            onTileTap: (_, __) {},
            onTileLongPress: (_, __) {},
          ),
        ),
      ),
    );

    expect(find.byType(BombIcon), findsOneWidget);
  });
} 