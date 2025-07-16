import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_text_styles.dart';
import '../../domain/entities/tile.dart';
import 'bomb_icon.dart';

class TileWidget extends StatelessWidget {
  final Tile tile;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const TileWidget({
    super.key,
    required this.tile,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: _getTileColor(),
          border: Border.all(color: AppColors.tileBorder),
        ),
        child: Center(
          child: _getTileContent(),
        ),
      ),
    );
  }

  Color _getTileColor() {
    if (!tile.isRevealed) {
      return AppColors.tileUnrevealed;
    }
    if (tile.hasMine) {
      return AppColors.tileMine;
    }
    return AppColors.tileRevealed;
  }

  Widget _getTileContent() {
    if (!tile.isRevealed && tile.isFlagged) {
      return const Icon(Icons.flag, color: AppColors.tileFlag);
    }
    if (!tile.isRevealed) {
      return const SizedBox();
    }
    if (tile.hasMine) {
      return const BombIcon(size: 24);
    }
    if (tile.adjacentMines == 0) {
      return const SizedBox();
    }
    return Text(
      '${tile.adjacentMines}',
      style: AppTextStyles.getTileNumber(tile.adjacentMines),
    );
  }
} 