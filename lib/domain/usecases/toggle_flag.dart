import '../entities/game_board.dart';
import '../repositories/game_repository.dart';

class ToggleFlag {
  final GameRepository repository;

  ToggleFlag(this.repository);

  GameBoard call(int x, int y) {
    return repository.toggleFlag(x, y);
  }
} 