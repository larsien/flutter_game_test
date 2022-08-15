import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter_game_test/game_state.dart';
import 'package:flutter_game_test/option.dart';

import 'constsnts.dart';

class DinoPlayer extends SpriteAnimationGroupComponent<GameState>
    with HasGameRef, CollisionCallbacks {
  DinoPlayer() : super(size: Vector2(88, 92));
  late final double initialYPosition;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox.relative(Vector2(0.8, 0.8), parentSize: size));

    anchor = Anchor.bottomLeft;
    final image = await Flame.images.load(Constants.spriteAsset);
    Sprite sprite1 =
        Sprite(image, srcPosition: Vector2(1338, 2), srcSize: Vector2(88, 94));
    Sprite sprite2 =
        Sprite(image, srcPosition: Vector2(1426, 2), srcSize: Vector2(88, 94));
    Sprite sprite3 =
        Sprite(image, srcPosition: Vector2(1514, 2), srcSize: Vector2(88, 94));
    Sprite sprite4 =
        Sprite(image, srcPosition: Vector2(1602, 2), srcSize: Vector2(88, 94));
    Sprite sprite5 =
        Sprite(image, srcPosition: Vector2(1690, 2), srcSize: Vector2(88, 94));

    animations = {
      GameState.beforeStart: SpriteAnimation.spriteList([
        sprite1,
        sprite2,
      ], stepTime: 0.3),
      GameState.play:
          SpriteAnimation.spriteList([sprite3, sprite4], stepTime: 0.3),
      GameState.gameover: SpriteAnimation.spriteList([sprite5], stepTime: 0.3),
    };
    current = gameState;
    initialYPosition = gameRef.size.y / 2 - sprite1.srcSize.y - 16;
    // sprite = await gameRef.loadSprite(Constants.finn);
    position = Vector2(0, initialYPosition);
    print("DinoPlayer : $position, ${sprite1.srcSize}");
  }

  double ACCELATION = 1200;
  double speedY = 0.0;
  double jumpSpeed = -500;
  int i = 0;
  @override
  void update(double t) {
    super.update(t);
    current = gameState;
    anchor = Anchor.topLeft;
    switch (gameState) {
      case GameState.beforeStart:
        position.x = 0;
        position.y = initialYPosition;
        break;
      case GameState.play:
        //60frame 인 경우 1frame은 0.0166초. t는 0.016
        speedY += ACCELATION * t; //V속도 = a가속도 * T. +=를 사용해 속도를 계속 증가
        position.y += (speedY * t) / 2; // S = V속도 * T시간. 속도가 증가하므로 가속도 운동
        if (position.y > initialYPosition) {
          position.y = initialYPosition;
          speedY = 0;
        }
        //앞으로 이동
        // position.x += GAME_SPEED;
        // if (position.x == 2500) {
        //   gameState = GameState.pause;
        // }

        // debugState(t);
        break;
      case GameState.gameover:
        // position.x
        break;
    }
  }

  void debugState(double t) {
    if (i % 60 == 59) {
      print(
          "dino : $i, gameState:$gameState, time : $t, speedY: $speedY, psition.x : ${position.x}, position.y : ${position.y}, initialYPosition : $initialYPosition");
      i = 0;
    }
    i++;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // if (other is DinoPlayer) {
    //   gameState = GameState.gameover;
    //   print("collision !!!!");
    // }
    super.onCollision(intersectionPoints, other);
  }
}
