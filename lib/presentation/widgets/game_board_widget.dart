import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';
import '../../domain/entities/game_board.dart';
import 'tile_widget.dart';

class GameBoardWidget extends StatelessWidget {
  final GameBoard board;
  final Function(int x, int y) onTileTap;
  final Function(int x, int y) onTileLongPress;

  const GameBoardWidget({
    super.key,
    required this.board,
    required this.onTileTap,
    required this.onTileLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: board.width / board.height,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.tileBorder),
        ),
        child: Column(
          children: List.generate(
            board.height,
            (y) => Expanded(
              child: Row(
                children: List.generate(
                  board.width,
                  (x) => Expanded(
                    child: TileWidget(
                      tile: board.tiles[y][x],
                      onTap: () => onTileTap(x, y),
                      onLongPress: () => onTileLongPress(x, y),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} 