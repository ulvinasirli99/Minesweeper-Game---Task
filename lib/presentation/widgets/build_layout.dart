import 'package:flutter/material.dart';

import '../../domain/entities/game_board.dart';
import '../controllers/game_controller.dart';
import 'game_board.dart';
import 'game_info.dart';

Widget buildPortraitLayout(
  BoxConstraints constraints,
  ValueNotifier<GameBoard?> boardNotifier,
  GameController controller,
) {
  return Column(
    children: [
      buildGameInfo(boardNotifier),
      const SizedBox(height: 16),
      Expanded(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth,
              maxHeight: constraints.maxWidth,
            ),
            child: buildGameBoard(boardNotifier, controller),
          ),
        ),
      ),
    ],
  );
}

Widget buildLandscapeLayout(
  BoxConstraints constraints,
  ValueNotifier<GameBoard?> boardNotifier,
  GameController controller,
) {
  final availableWidth = constraints.maxWidth - 200; // Space for info panel
  final maxGameSize = constraints.maxHeight * 0.9; // 90% of height
  final gameSize = availableWidth < maxGameSize ? availableWidth : maxGameSize;

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(width: 200, child: buildGameInfo(boardNotifier)),
      Expanded(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: gameSize,
              maxHeight: gameSize,
            ),
            child: buildGameBoard(boardNotifier, controller),
          ),
        ),
      ),
    ],
  );
}
