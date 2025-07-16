import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/entities/game_board.dart';
import '../../domain/usecases/create_game.dart';
import '../../domain/usecases/reveal_tile.dart';
import '../../domain/usecases/toggle_flag.dart';

class GameController {
  final CreateGame _createGame;
  final RevealTile _revealTile;
  final ToggleFlag _toggleFlag;

  final ValueNotifier<GameBoard?> boardNotifier = ValueNotifier<GameBoard?>(null);
  Timer? _timer;
  int _currentElapsedSeconds = 0;

  GameController({
    required CreateGame createGame,
    required RevealTile revealTile,
    required ToggleFlag toggleFlag,
  })  : _createGame = createGame,
        _revealTile = revealTile,
        _toggleFlag = toggleFlag;

  bool get isGameInitialized => boardNotifier.value != null;

  void startNewGame(int width, int height, int mineCount) {
    _stopTimer();
    _currentElapsedSeconds = 0;
    boardNotifier.value = _createGame(width, height, mineCount);
    _startTimer();
  }

  void revealTile(int x, int y) {
    if (!isGameInitialized) return;
    final currentSeconds = boardNotifier.value!.elapsedSeconds;
    boardNotifier.value = _revealTile(x, y);
    if (boardNotifier.value!.isGameOver) {
      _stopTimer();
    } else {
      // Preserve the elapsed time
      boardNotifier.value = boardNotifier.value!.copyWith(
        elapsedSeconds: currentSeconds,
      );
    }
  }

  void toggleFlag(int x, int y) {
    if (!isGameInitialized) return;
    final currentSeconds = boardNotifier.value!.elapsedSeconds;
    boardNotifier.value = _toggleFlag(x, y);
    // Preserve the elapsed time
    boardNotifier.value = boardNotifier.value!.copyWith(
      elapsedSeconds: currentSeconds,
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isGameInitialized || boardNotifier.value!.isGameOver) return;
      _currentElapsedSeconds = boardNotifier.value!.elapsedSeconds + 1;
      boardNotifier.value = boardNotifier.value!.copyWith(
        elapsedSeconds: _currentElapsedSeconds,
      );
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    _stopTimer();
    boardNotifier.dispose();
  }
} 