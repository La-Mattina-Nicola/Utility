import 'dart:async';
import 'package:flutter/material.dart';
import 'package:utility/components/games/tetris_piece.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength, (j) => null,
  )
);


class TetrisGame extends StatefulWidget {
  const TetrisGame({super.key});

  @override
  State<TetrisGame> createState() => _TetrisGameState();
}

class _TetrisGameState extends State<TetrisGame> {
  //Grid

  TetrisPiece currentPiece = TetrisPiece(type: Tetromino.L);

  @override
  void initState() {
    super.initState();
    startGame();
  }
  @override
  void dispose() {
    super.dispose();
  }

  void startGame() {
    currentPiece.initalizePiece();
    Duration frameRate = const Duration(milliseconds: 300);
    gameLoop(frameRate);

  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer) {
        setState(() {
          currentPiece.movePiece(Direction.down);
          createNewPiece();
        });
      }
    );
  }

  int cpt = 0;
  void createNewPiece() {
    cpt += 1;
    if (cpt == 18) {
      currentPiece.initalizePiece();
      cpt = 0;
    }
  }

  bool checkCollision(Direction direction) {
    for(int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = (currentPiece.position[i] % rowLength);

      if(direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // check if out of bounds
      if(row >= colLength || col < 0 || col>= rowLength) {
        return true;
      }
    }
    return false;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 20,),
          // Affichage Score et piece suivante
          const Expanded(
            flex:1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("T", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, color: Colors.red),),
                Text("E", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, color: Colors.orange),),
                Text("T", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, color: Colors.yellow),),
                Text("R", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, color: Colors.green),),
                Text("I", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, color: Colors.blue),),
                Text("S", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, color: Colors.purple),),
              ],
            ),
          ),
          // Game
          Expanded(
            flex: 6,
            child: Row(
              children: [
                const SizedBox(width: 10,),
                Expanded(
                  flex: 5,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: rowLength* colLength,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowLength,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      // Show current piece
                      if(currentPiece.position.contains(index)) {
                        return Center(
                          child : Container(
                            margin: const EdgeInsets.all(1.0),  
                            decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(4.0), 
                              color: Colors.orange
                            ),
                          )
                        );
                      } else {
                        return Center(
                        child : Container(
                          margin: const EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(4.0), 
                            color: Colors.grey[900] as Color
                            ),
                          )
                        );
                      }
                    } 
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 25,),
                      const Text("Score :"),
                      const Text("9999", style: TextStyle(fontSize: 20),),
                      const SizedBox(height: 30,),
                      const Text("NEXT",),
                      Expanded(
                        flex: 1,
                        child: GridView.builder(
                          itemCount: 4*4,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4 
                          ),
                          itemBuilder: (BuildContext context, int index) { 
                            return Center(
                              child: Container(
                                margin: const EdgeInsets.all(1.0),
                                decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(2.0), 
                                  color: Colors.grey[900] as Color
                                ),
                              )
                            );
                           },
                        )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Controle
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(bottom: 40, top: 40, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius:BorderRadius.circular(8.0), 
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius:BorderRadius.circular(4.0), 
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Icons.arrow_circle_left_outlined, size: 30,)
                    ),
                    onTap: () {currentPiece.movePiece(Direction.left);},
                  ),
                  GestureDetector(
                    child: const Icon(Icons.rotate_left_sharp, size: 30,),
                    onTap: () {},
                  ),
                  GestureDetector(
                    child: const Icon(Icons.rotate_right_sharp, size: 30,),
                    onTap: () {},
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius:BorderRadius.circular(4.0), 
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Icons.arrow_circle_right_outlined, size: 30,)
                    ),
                    onTap: () {currentPiece.movePiece(Direction.right);},
                  ),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}