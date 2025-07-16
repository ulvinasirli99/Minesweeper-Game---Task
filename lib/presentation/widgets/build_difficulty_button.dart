import 'package:flutter/material.dart';
import '../../app/routes.dart';
import '../../data/repositories/game_repository_impl.dart';
import '../../domain/usecases/create_game.dart';
import '../../domain/usecases/reveal_tile.dart';
import '../../domain/usecases/toggle_flag.dart';
import '../controllers/game_controller.dart';
import '../screens/game_screen.dart';

GameController _createController() {
  final gameRepository = GameRepositoryImpl();
  final createGame = CreateGame(gameRepository);
  final revealTile = RevealTile(gameRepository);
  final toggleFlag = ToggleFlag(gameRepository);

  return GameController(
    createGame: createGame,
    revealTile: revealTile,
    toggleFlag: toggleFlag,
  );
}

Widget buildDifficultyButton(
  BuildContext context,
  String label,
  String description,
  int width,
  int height,
  int mines,
  double buttonWidth,
) {
  return SizedBox(
    width: buttonWidth,
    child: ElevatedButton(
      onPressed: () {
        final controller = _createController();
        controller.startNewGame(width, height, mines);
        AppRoute.push(context, GameScreen(controller: controller));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
