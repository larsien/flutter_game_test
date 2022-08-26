import 'dart:developer';
import 'dart:math' hide log;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter_game_test/dino.dart';
import 'package:flutter_game_test/game_state.dart';
import 'package:flutter_game_test/score.dart';

import 'dino_game.dart';

class Coin extends SpriteAnimationComponent
    with HasGameRef<DinoGame>, CollisionCallbacks {
  Coin(this.positionX, [this.positionY = -1]);

  final double positionX;
  final double positionY;

  final int randomPositionYMax = 75;
  late int coinValue = Random().nextInt(randomPositionYMax) + 1;

  int logI = 0;
  SpriteAnimation? feverItem;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    anchor = Anchor.center;
    //set image
    if (coinValue == randomPositionYMax && gameState != GameState.fever) {
      final image2 = Flame.images.fromCache('fever_item1.png');
      final image3 = Flame.images.fromCache('fever_item2.png');
      SpriteAnimationFrame frame2 = SpriteAnimationFrame(Sprite(image2), 0.15);
      SpriteAnimationFrame frame3 = SpriteAnimationFrame(Sprite(image3), 0.15);
      feverItem = SpriteAnimation([frame2, frame3]);

      animation = feverItem;
    } else {
      final img = Flame.images.fromCache('item1.png');
      SpriteAnimationFrame itemImage = SpriteAnimationFrame(Sprite(img), 0.3);

      animation = SpriteAnimation([
        itemImage,
      ]);
    }
    //set size
    double coinSize = gameRef.dinoSize * 0.4;
    size = Vector2(coinSize, coinSize);

    //set hitbox
    add(CircleHitbox.relative(0.7, parentSize: size)
      ..collisionType = CollisionType.passive);

    //set position
    position.x = positionX;
    double positionMaxY = gameRef.dinoSize;
    Random randomDeltaY = Random();
    double coinPositionY =
        randomDeltaY.nextInt(positionMaxY.toInt()).toDouble();
    if (positionY == -1) {
      position.y =
          gameRef.size.y / 2 - coinPositionY - 80; //cactus minimum size is 80
    }
    log("coin size $size, r :$coinValue,  position.x : $position, $coinPositionY");
  }

  void setPosition(double x, double y) {
    position.x = x;
    position.y = y;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, gameRef.dino);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Dino) {
      if (coinValue == randomPositionYMax && feverItem != null) {
        gameRef.children.query<ScoreComponent>().first.addScore(0.9);
        gameRef.dino.startFever();
      } else {
        gameRef.children.query<ScoreComponent>().first.addScore(0.3);
      }
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  double angleTo = 0.03;
  @override
  void update(double dt) {
    super.update(dt);
    switch (gameState) {
      case GameState.beforeStart:
        gameRef.children.query<ScoreComponent>().first.clearScore();
        removeFromParent();
        break;
      case GameState.invulnerable:
      case GameState.fever:
      case GameState.play:
        position.x -= gameRef.gameSpeed;
        angle += angleTo;

        log("angle $angle, $angleTo, ");

        // if (position.x < -200) {
        //   removeFromParent();
        // }
        break;
      case GameState.gameover:
        break;
    }
    debugState(dt);
  }

  void debugState(double t) {
    if (logI % 60 == 59) {
      log("$logI, gameState:$gameState, time : $t,  psition.x : ${position.x}, position.y : ${position.y}, ");
      logI = 0;
    }
    logI++;
  }
}
