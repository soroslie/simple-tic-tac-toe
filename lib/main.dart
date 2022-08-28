import 'package:flutter/material.dart';
import 'package:simple_tic_tac_toe/ui/theme/color.dart';
import 'package:simple_tic_tac_toe/ui/utils/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "X";
  bool gameOver = false;
  List<int> scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  int turn = 0; // to check the draw
  String result = "";

  //game
  Game game = Game();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It's ${lastValue} Turn",
            style: TextStyle(
                color: lastValue == "X" ? Colors.blue : Colors.pink,
                fontSize: 40),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
                crossAxisCount: Game.boardLength ~/ 3,
                padding: EdgeInsets.all(16.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(Game.boardLength, (index) {
                  return InkWell(
                    onTap: gameOver
                        ? null
                        : () {
                            setState(() {
                              if (game.board![index] == "") {
                                game.board![index] = lastValue;
                                turn ++;
                                gameOver = game.winnerCheck(
                                    lastValue, index, scoreBoard, 3);

                                if (gameOver) {
                                  result = "$lastValue is the Winner";
                                } else if (!gameOver && turn == 9) {
                                  result = "It's a Draw!";
                                  gameOver = true;
                                }
                                if (lastValue == "X") {
                                  lastValue = "O";
                                } else {
                                  lastValue = "X";
                                }
                              }
                            });
                          },
                    child: Container(
                      width: Game.blocSize,
                      height: Game.blocSize,
                      decoration: BoxDecoration(
                          color: MainColor.secondaryyColor,
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                              fontSize: 64,
                              color: game.board![index] == "X"
                                  ? Colors.blue
                                  : Colors.pink),
                        ),
                      ),
                    ),
                  );
                })),
          ),
          Text(
            result,
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: MainColor.primaryColor
            ),
            onPressed: () {
              setState(() {
                //erase the board
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn = 0;
                result = "";
                scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
            icon: Icon(Icons.replay),
            label: Text("Reset"),
          )
        ],
      ),
    );
  }
}
