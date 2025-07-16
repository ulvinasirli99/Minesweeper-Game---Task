import 'package:flutter/material.dart';

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
              board.status == GameStatus.won ? 'You Won! 🎉' : 'Game Over! 💣',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _buildInfoCard(
                  'Mines',
                  '${board.mineCount - board.flagCount}',
                  Icons.flag,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildInfoCard(
                  'Time',
                  '${board.elapsedSeconds}',
                  Icons.timer,
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
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}