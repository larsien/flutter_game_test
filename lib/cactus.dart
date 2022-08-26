import 'dart:developer';
import 'dart:math' hide log;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter_game_test/dino.dart';
import 'package:flutter_game_test/game_state.dart';

import 'constsnts.dart';
import 'dino_game.dart';

class Cactus extends SpriteComponent
    with HasGameRef<DinoGame>, CollisionCallbacks {
  Cactus(this.positionX) : super();

  final double positionX;
  int i = 0;
  double jumpSpeed = -500;
  final double cactusMinimumSize = 80;
  final int randomHeightMax = 10;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    anchor = Anchor.bottomCenter;
    //set image
    final image = await Flame.images.load('cactus.png');
    sprite = Sprite(image);
    // Sprite sprite2 =
    //     Sprite(image, srcPosition: Vector2(701, 2), srcSize: Vector2(49, 100));
    //set position
    double positionY = gameRef.size.y / 2 - gameRef.dinoLand.size.y;
    position = Vector2(positionX, positionY);
    //set size
    int heightToAdd = Random().nextInt(randomHeightMax) + 1;
    size = Vector2(30, cactusMinimumSize + heightToAdd.toDouble());
    add(RectangleHitbox.relative(Vector2(0.4, 0.5), parentSize: size));
    log("cactus : $size ");
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (gameState == GameState.play) {
      if (other is Dino) {
        gameState = GameState.gameover;
        gameRef.overlays.add(Constants.overlayName);
      }
    } else {
      if (other is Dino) {
        removeFromParent();
        gameRef.scoreComponent.addScore(10);
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    super.update(dt);
    switch (gameState) {
      case GameState.beforeStart:
        removeFromParent();
        break;
      case GameState.invulnerable:
      case GameState.play:
      case GameState.fever:
        if (gameState == GameState.fever) {}

        position.x -= gameRef.gameSpeed;
        if (position.x < -200) {
          removeFromParent();
        }
        break;

      case GameState.gameover:
        break;
    }
  }

  void debugState(double t) {
    if (i % 60 == 59) {
      log("$i, gameState:$gameState, time : $t, psition.x : ${position.x}, position.y : ${position.y}, ");
      i = 0;
    }
    i++;
  }
}
