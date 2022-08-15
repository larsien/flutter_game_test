import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter_game_test/dino_player.dart';
import 'package:flutter_game_test/game_state.dart';
import 'package:flutter_game_test/option.dart';

import 'constsnts.dart';
import 'dino_game.dart';

class Cactus extends SpriteComponent
    with HasGameRef<DinoGame>, CollisionCallbacks {
  Cactus() : super(size: Vector2(88, 92));
  late final double yPosition;
  List<Sprite?> cactusList = [];
  double worldGroundYSize = 12;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    //add hitbox
    add(RectangleHitbox.relative(Vector2(0.8, 0.8), parentSize: size));

    anchor = Anchor.bottomLeft;
    final image = await Flame.images.load(Constants.spriteAsset);
    sprite =
        Sprite(image, srcPosition: Vector2(652, 2), srcSize: Vector2(49, 100));
    Sprite sprite2 =
        Sprite(image, srcPosition: Vector2(701, 2), srcSize: Vector2(49, 100));
    Sprite sprite3 =
        Sprite(image, srcPosition: Vector2(752, 2), srcSize: Vector2(50, 100));
    cactusList.add(sprite);
    cactusList.add(sprite2);
    cactusList.add(sprite3);
    anchor = Anchor.bottomCenter;
    yPosition = gameRef.size.y / 2 - worldGroundYSize;
    // sprite = await gameRef.loadSprite(Constants.finn);
    // position = Vector2(gameRef.size.x, yPosition);
    // print("Cactus : $position, ${sprite1.srcSize}");
  }

  double ACCELATION = 1200;
  double speedY = 0.0;
  double jumpSpeed = -500;
  double xLocation = 595;
  int i = 0;
  void getRandomCactus(double locationX) {
    Random random = Random();
    sprite = cactusList[random.nextInt(cactusList.length)];
    position.x = locationX;
    position.y = yPosition;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // if (other is DinoPlayer) {
    //   gameState = GameState.gameover;
    //   print("collision !!!!");
    // }
    super.onCollision(intersectionPoints, gameRef.dino);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is DinoPlayer) {
      gameState = GameState.gameover;
      print("collision start !!!!");
    }
    super.onCollisionStart(intersectionPoints, other);
  }
  // @override
  // void onConllision(){
  //   super.onCollision(intersectionPoints, other)
  // }

  @override
  void update(double t) {
    super.update(t);
    switch (gameState) {
      case GameState.beforeStart:
        break;
      case GameState.play:
        position.x -= GAME_SPEED;
        break;
      case GameState.gameover:
        break;
    }
  }

  void debugState(double t) {
    if (i % 60 == 59) {
      print(
          "$i, gameState:$gameState, time : $t, speedY: $speedY, psition.x : ${position.x}, position.y : ${position.y}, initialYPosition : $yPosition");
      i = 0;
    }
    i++;
  }
}
