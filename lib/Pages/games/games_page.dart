import 'package:flutter/material.dart';
import 'package:utility/Pages/games/chess_page.dart';
import 'package:utility/Pages/games/tetris_page.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Games"),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.square),
            title: const Text("Chess Game"),
            trailing: const Text("2 player game, kill the king !"),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => const ChessGame(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shape_line_outlined),
            title: const Text("Tetris"),
            trailing: const Text("Make row to score"),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => const TetrisGame(),
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}