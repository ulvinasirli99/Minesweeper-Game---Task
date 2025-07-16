import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/app_text_styles.dart';
import '../../core/constant/app_constant.dart';
import '../../core/constant/menu_constant.dart';
import '../../core/enums/game_state.dart';
import '../../core/utils/game_config_generator.dart';
import '../widgets/build_difficulty_button.dart';

class DifficultyLevel {
  const DifficultyLevel({
    required this.title,
    required this.description,
    required this.gameState,
  });

  final String title;
  final String description;
  final GameState gameState;
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  static const _difficultyLevels = [
    DifficultyLevel(
      title: 'Easy',
      description: '8x8 grid with 10 mines',
      gameState: GameState.easy,
    ),
    DifficultyLevel(
      title: 'Medium',
      description: '12x12 grid with 30 mines',
      gameState: GameState.medium,
    ),
    DifficultyLevel(
      title: 'Hard',
      description: '16x16 grid with 60 mines',
      gameState: GameState.hard,
    ),
  ];

  double _getSpacing(bool isLandscape) =>
      isLandscape ? menuLevelSpace8 : menuLevelSpace16;

  double _getTitleSpacing(bool isLandscape) =>
      isLandscape ? menuLevelSpace16 : menuLevelSpace32;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        centerTitle: true,
        backgroundColor: AppColors.getAppBarColor(context),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isLandscape = constraints.maxWidth > constraints.maxHeight;
            final buttonWidth =
                isLandscape
                    ? constraints.maxWidth * 0.4
                    : constraints.maxWidth * 0.8;

            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Select Difficulty',
                        style: AppTextStyles.menuTitle,
                      ),
                      SizedBox(height: _getTitleSpacing(isLandscape)),
                      ..._buildDifficultyButtons(
                        context,
                        buttonWidth,
                        isLandscape,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildDifficultyButtons(
    BuildContext context,
    double buttonWidth,
    bool isLandscape,
  ) {
    final List<Widget> buttons = [];

    for (var i = 0; i < _difficultyLevels.length; i++) {
      if (i > 0) {
        buttons.add(SizedBox(height: _getSpacing(isLandscape)));
      }

      final level = _difficultyLevels[i];
      buttons.add(
        buildDifficultyButton(
          context,
          level.title,
          level.description,
          tileWidthGenerator(level.gameState),
          tileHeightGenerator(level.gameState),
          tileMinesGenerator(level.gameState),
          buttonWidth,
        ),
      );
    }

    return buttons;
  }
}
