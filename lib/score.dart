import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_test/dino_game.dart';

class ScoreComponent extends HudMarginComponent<DinoGame> {
  double score = 0;

  ScoreComponent({
    super.margin = const EdgeInsets.only(top: 50, left: 90),
  });

  @override
  Future<void> onLoad() {
    return super.onLoad();
  }

  @override
  void onMount() {
    final textComponent = TextComponent(
      text: "OPI: 0 %",
      textRenderer: TextPaint(
        style: Theme.of(gameRef.buildContext!)
            .textTheme
            .headline3!
            .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
    add(textComponent);
    children.register<TextComponent>();
    super.onMount();
  }

  void addScore(double inputScore) {
    score += inputScore;
    score = double.parse((score).toStringAsFixed(1));
    children.query<TextComponent>().first.text = "OPI: $score %";
  }

  void clearScore() {
    score = 0;
    children.query<TextComponent>().first.text = "OPI: 0 %";
  }
}
