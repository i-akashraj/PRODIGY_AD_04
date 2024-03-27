import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: TicTacToeBoard(),
      ),
    );
  }
}

class TicTacToeBoard extends StatefulWidget {
  @override
  _TicTacToeBoardState createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  List<List<String>> _board = List.generate(3, (_) => List.filled(3, ' '));
  bool _xTurn = true;
  bool _gameEnded = false;

  void _handleTap(int row, int col) {
    if (!_gameEnded && _board[row][col] == ' ') {
      setState(() {
        _board[row][col] = _xTurn ? 'X' : 'O';
        _xTurn = !_xTurn;
        _checkGameEnded();
      });
    }
  }

  void _checkGameEnded() {
    // Check rows, columns, and diagonals for a win
    for (int i = 0; i < 3; i++) {
      if (_board[i].every((element) => element == _board[i][0]) && _board[i][0] != ' ') {
        setState(() {
          _gameEnded = true;
        });return;
      }
      if (_board.map((e) => e[i]).toList().every((element) => element == _board[0][i]) && _board[0][i] != ' ') {
        setState(() {
          _gameEnded = true;
        });
        return;
      }
    }
    if (_board[0][0] == _board[1][1] && _board[1][1] == _board[2][2] && _board[0][0] != ' ') {
      setState(() {
        _gameEnded = true;
      });
      return;
    }
    if (_board[0][2] == _board[1][1] && _board[1][1] == _board[2][0] && _board[0][2] != ' ') {
      setState(() {
        _gameEnded = true;
      });
      return;
    }

    // Check if the board is full (no empty spaces left)
    if (!_board.any((row) => row.contains(' '))) {
      setState(() {
        _gameEnded = true;
      });
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.filled(3, ' '));
      _xTurn = true;
      _gameEnded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          children: List.generate(9, (index) {
            final row = index ~/ 3;
            final col = index % 3;
            return GestureDetector(
              onTap: () => _handleTap(row, col),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    _board[row][col],
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            );
          }),
        ),
        if (_gameEnded)
          ElevatedButton(
            onPressed: _resetGame,
            child: Text('Reset Game'),
          ),
      ],
    );
  }
}