class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static final boardLength = 9;
  static final blocSize = 100.0;

  //Board
  List<String>? board;

  static List<String>? initGameBoard() =>
      List.generate(boardLength, (index) => Player.empty);

  bool winnerCheck(
      String player, int index, List<int> scoreboard, int gridSize) {
    int row = index ~/ 3;
    int col = index % 3;

    int score = player == "X" ? 1 : -1;

    scoreboard[row] += score;
    scoreboard[gridSize + col] += score;
    if (row == col) scoreboard[2 * gridSize] += score;
    if (gridSize - 1 - col == row) scoreboard[2 * gridSize + 1] += score;

    //checking if we have 3 or -3 in the score board
    if (scoreboard.contains(3) || scoreboard.contains(-3)) {
      return true;
    }
    ;

    return false;
  }
}
