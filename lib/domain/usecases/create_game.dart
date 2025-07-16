import '../entities/game_board.dart';
import '../repositories/game_repository.dart';

class CreateGame {
  final GameRepository repository;

  CreateGame(this.repository);

  GameBoard call(int width, int height, int mineCount) {
    return repository.createNewGame(width, height, mineCount);
  }
} 