import 'dart:developer';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter_game_test/dino_game.dart';
import 'package:flutter_game_test/game_state.dart';

class Dino extends SpriteAnimationGroupComponent<GameState>
    with HasGameRef<DinoGame>, CollisionCallbacks {
  Dino();
  late final double initialYPosition;

  double accelation = 6500;
  double speedY = 0.0;
  double jumpSpeed = -1700;
  int i = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    size = Vector2(gameRef.dinoSize, gameRef.dinoSize);
    //hitbox
    add(RectangleHitbox.relative(Vector2(0.8, 0.8), parentSize: size));
    log('character size $size');
    anchor = Anchor.bottomLeft;
    final image1 = await Flame.images.load('ms_flip.png');
    final image2 = await Flame.images.load('ms_flip2.png');
    final image2Invulanerable =
        await Flame.images.load('ms_flip2_invulaberable.png');
    final image3 = await Flame.images.load('mr_folder1.png');
    final image4 = await Flame.images.load('mr_folder2.png');
    Sprite waitCharacterSprite = Sprite(image1);
    Sprite runningCharacterSprite = Sprite(image2);
    Sprite runningCharacterInvulanerable = Sprite(image2Invulanerable);
    Sprite runningMrFolder1 = Sprite(image3);
    Sprite runningMrFolder2 = Sprite(image4);
    // Sprite sprite3 =
    //     Sprite(image, srcPosition: Vector2(1514, 2), srcSize: Vector2(88, 94));
    // Sprite sprite4 =
    //     Sprite(image, srcPosition: Vector2(1602, 2), srcSize: Vector2(88, 94));
    // Sprite sprite5 =
    //     Sprite(image, srcPosition: Vector2(1690, 2), srcSize: Vector2(88, 94));
    SpriteAnimation msFlip = SpriteAnimation.spriteList(
        [waitCharacterSprite, runningCharacterSprite],
        stepTime: 0.2);
    SpriteAnimation msFlipInvulanerable = SpriteAnimation.spriteList(
        [waitCharacterSprite, runningCharacterInvulanerable],
        stepTime: 0.3);

    SpriteAnimation mrFolder = SpriteAnimation.spriteList(
        [runningMrFolder1, runningMrFolder2],
        stepTime: 0.15);

    animations = {
      GameState.beforeStart: SpriteAnimation.spriteList(
          [waitCharacterSprite, waitCharacterSprite],
          stepTime: 1),
      GameState.invulnerable: msFlipInvulanerable,
      GameState.play: msFlip,
      GameState.fever: mrFolder,
      GameState.gameover:
          SpriteAnimation.spriteList([runningCharacterSprite], stepTime: 1),
    };
    current = gameState;
    double worldHeight = gameRef.dinoLand.size.y;
    initialYPosition = gameRef.size.y / 2 - size.y - worldHeight;
    // sprite = await gameRef.loadSprite(Constants.finn);
    position = Vector2(0, initialYPosition);
    log("DinoPlayer : $size, $position, ${waitCharacterSprite.srcSize}");
  }

  @override
  void update(double dt) {
    super.update(dt);
    current = gameState;
    anchor = Anchor.topLeft;
    switch (gameState) {
      case GameState.beforeStart:
        position.x = 0;
        position.y = initialYPosition;
        break;
      case GameState.invulnerable:
      case GameState.play:
      case GameState.fever:
        if (gameState == GameState.fever) {
          size = Vector2(gameRef.dinoSize * 1.0, gameRef.dinoSize * 1.0);
        } else {
          size = Vector2(gameRef.dinoSize, gameRef.dinoSize);
        }
        //60frame ??? ?????? 1frame??? 0.0166???. t??? 0.016
        speedY += accelation * dt; //V?????? = a????????? * T. +=??? ????????? ????????? ?????? ??????
        position.y += (speedY * dt) / 2; // S = V?????? * T??????. ????????? ??????????????? ????????? ??????
        //fevermode ??????/????????? ????????? ?????? ???
        if (position.x < 0) {
          position.x += 20;
        }
        if (position.y > initialYPosition) {
          position.y = initialYPosition;
          speedY = 0;
        }
        //????????? ??????
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

  int feverEndFrame = -1;
  void startFever() async {
    if (gameState != GameState.fever) {
      speedY = -3000;
      await Future.delayed(const Duration(milliseconds: 150));
      gameState = GameState.fever;
      // speedY = 300;
      speedY = 0;
      position.x = -200;
      position.y = initialYPosition;
      feverEndFrame = gameRef.currentFrame + 330;
    }
  }

  void endFever() async {
    if (gameState == GameState.fever) {
      speedY = -3000;
      await Future.delayed(const Duration(milliseconds: 150));
      gameState = GameState.invulnerable;
      speedY = 0;
      position.x = -200;
      position.y = initialYPosition;
      Future.delayed(const Duration(milliseconds: 1000))
          .then((value) => {gameState = GameState.play});
    }
  }

  void debugState(double t) {
    if (i % 60 == 59) {
      log("dino : $i, gameState:$gameState, time : $t, speedY: $speedY, psition.x : ${position.x}, position.y : ${position.y}, initialYPosition : $initialYPosition");
      i = 0;
    }
    i++;
  }
}
