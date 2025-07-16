import '../entities/game_board.dart';
import '../repositories/game_repository.dart';

class RevealTile {
  final GameRepository repository;

  RevealTile(this.repository);

  GameBoard call(int x, int y) {
    return repository.revealTile(x, y);
  }
} 