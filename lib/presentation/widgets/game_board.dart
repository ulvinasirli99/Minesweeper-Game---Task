import 'package:flutter/material.dart';

import '../../core/constant/app_string_constant.dart';
import '../../domain/entities/game_board.dart';
import '../controllers/game_controller.dart';
import 'game_board_widget.dart';

Widget buildGameBoard(
  ValueNotifier<GameBoard?> boardNotifier,
  GameController controller,
) {
  return ValueListenableBuilder(
    valueListenable: boardNotifier,
    builder: (context, board, child) {
      if (board == null) {
        return const Center(child: Text(loadingText));
      }
      return GameBoardWidget(
        board: board,
        onTileTap: controller.revealTile,
        onTileLongPress: controller.toggleFlag,
      );
    },
  );
}
