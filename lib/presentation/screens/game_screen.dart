import 'package:flutter/material.dart';
import '../../app/routes.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_icons.dart';
import '../../core/constant/app_string_constant.dart';
import '../controllers/game_controller.dart';
import '../widgets/build_layout.dart';

class GameScreen extends StatefulWidget {
  final GameController controller;

  const GameScreen({super.key, required this.controller});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, _) async {
        widget.controller.boardNotifier.value = null;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(appName),
          centerTitle: true,
          backgroundColor: AppColors.getAppBarColor(context),
          leading: IconButton(
            icon: Icon(AppIcons.back),
            onPressed: () {
              widget.controller.boardNotifier.value = null;
              AppRoute.pop(context);
            },
          ),
          actions: [
            ValueListenableBuilder(
              valueListenable: widget.controller.boardNotifier,
              builder: (context, board, child) {
                if (board?.isGameOver ?? false) {
                  return IconButton(
                    icon: Icon(AppIcons.refresh),
                    onPressed: () {
                      widget.controller.startNewGame(
                        board!.width,
                        board.height,
                        board.mineCount,
                      );
                    },
                    tooltip: restartGameTooltip,
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isLandscape = constraints.maxWidth > constraints.maxHeight;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    isLandscape
                        ? buildLandscapeLayout(
                          constraints,
                          widget.controller.boardNotifier,
                          widget.controller,
                        )
                        : buildPortraitLayout(
                          constraints,
                          widget.controller.boardNotifier,
                          widget.controller,
                        ),
              );
            },
          ),
        ),
      ),
    );
  }
}
