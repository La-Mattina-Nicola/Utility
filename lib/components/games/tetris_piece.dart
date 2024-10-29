int rowLength = 10;
int colLength = 15;

enum Tetromino{
  L, J, I, O, S, Z, T
}

enum Direction{
  left, right, down
}

class TetrisPiece {
  Tetromino type;

  TetrisPiece({required this.type});
  List<int> position = [];

  void initalizePiece() {
    switch(type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];
      break;
      case Tetromino.J:
        position = [5, 15, 24, 25];
      break;
      case Tetromino.I:
        position = [3, 4, 5, 6];
      break;
      case Tetromino.O:
        position = [4, 5, 14, 15];
      break;
      case Tetromino.S:
        position = [5, 6, 14, 15];
      break;
      case Tetromino.Z:
        position = [4, 5, 15, 16];
      break;
      case Tetromino.T:
        position = [4, 5, 6, 15];
      break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch(direction) {
      case Direction.down:
        for(int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
      break;
      case Direction.left:
        for(int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
      break;
      case Direction.right:
        for(int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
      break;
      default:
    }
  }
}