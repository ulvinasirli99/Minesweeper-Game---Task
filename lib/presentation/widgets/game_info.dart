import 'package:flutter/material.dart';
import 'package:minesweeper_game/core/constant/app_string_constant.dart';
import '../../core/constant/app_icons.dart';
import '../../core/constant/app_text_styles.dart';
import '../../domain/entities/game_board.dart';

Widget buildGameInfo(ValueNotifier<GameBoard?> boardNotifier) {
  return ValueListenableBuilder(
    valueListenable: boardNotifier,
    builder: (context, board, child) {
      if (board == null) {
        return const SizedBox();
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (board.isGameOver)
            Text(
              board.status == GameStatus.won ? gameWinMessage : gameOverMessage,
              style: AppTextStyles.gameResultStyle,
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _buildInfoCard(
                  minesText,
                  '${board.mineCount - board.flagCount}',
                  AppIcons.flag,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildInfoCard(
                  timeText,
                  '${board.elapsedSeconds}',
                  AppIcons.timer,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Widget _buildInfoCard(String title, String value, IconData icon) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTextStyles.gameInfoCardTitleStyle),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 4),
              Text(value, style: AppTextStyles.gameInfoCardSubTitleStyle),
            ],
          ),
        ],
      ),
    ),
  );
}
