import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_test/dino_game.dart';

void main() async {
  final game = DinoGame();
  runApp(GameWidget(
    game: game,
  ));
}
