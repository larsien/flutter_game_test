import 'dart:developer';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter_game_test/button.dart';
import 'package:flutter_game_test/cactus.dart';
import 'package:flutter_game_test/coin.dart';
import 'package:flutter_game_test/constsnts.dart';
import 'package:flutter_game_test/dino.dart';
import 'package:flutter_game_test/dino_background.dart';
import 'package:flutter_game_test/dino_land.dart';
import 'package:flutter_game_test/game_state.dart';
import 'package:flutter_game_test/score.dart';

class DinoGame extends FlameGame
    with HasTappableComponents, HasCollisionDetection {
  final ScoreComponent scoreComponent = ScoreComponent();
  final DinoBackground _dinoBackground = DinoBackground();
  final DinoLand dinoLand = DinoLand();
  final Button _button = Button();
  final Dino dino = Dino();

  final double characterRatio = 3; //n 분의 1
  final double coinRatio = 15; //n 분의 1
  final double dinoSize = 100;

  int initialGameSpeed = 3;
  int gameSpeed = 3;

  double cactusPositionX = 800;

  int currentFrame = 0;
  double elapsedTime = 0;
  int logI = 0;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    Flame.images.loadAllImages();
    await add(_dinoBackground);
    await add(dinoLand);
    await add(dino);
    await add(_button);
    await add(scoreComponent);
    log("size x : ${size.x}, size y : ${size.y}");
  }

  @override
  void update(double dt) {
    super.update(dt);
    elapsedTime += dt;
    currentFrame += 1;
    switch (gameState) {
      case GameState.beforeStart:
        break;
      case GameState.fever:
      case GameState.invulnerable:
      case GameState.play:
        if (gameState == GameState.fever && currentFrame > dino.feverEndFrame) {
          dino.endFever();
        }
        if (scoreComponent.score > 25) {
          gameSpeed = 6;
        } else if (scoreComponent.score > 50) {
          gameSpeed = 9;
        } else if (scoreComponent.score > 60) {
          gameSpeed = 12;
        } else if (scoreComponent.score > 70) {
          gameSpeed = 15;
        } else if (scoreComponent.score > 80) {
          gameSpeed = 18;
        } else if (scoreComponent.score > 90) {
          gameSpeed = 21;
        }
        if (elapsedTime > 1) {
          for (int k = 0; k <= 10; k += 10) {
            add(Coin(cactusPositionX + k));
            if (gameState == GameState.fever) {
              add(Coin(cactusPositionX + k + 50));
              add(Coin(cactusPositionX + k + 70));
            }
          }
        }
        // }
        if (elapsedTime > 1) {
          // if (dinoMoved % size.x == GAME_SPEED * 1) {
          add(Cactus(cactusPositionX));
        }
        // log(
        //     "$frame, dinoMoved: $dinoMoved,zFlipScreenWidthHeight.x: ${size.x} ");

        break;
      case GameState.gameover:
        gameSpeed = initialGameSpeed;
        break;
    }
    if (elapsedTime > 1) {
      elapsedTime = 0;
    }

    printDebug(dt);
  }

  void printDebug(double t) {
    if (logI % 30 == 0) {
      log("$logI, sumtime : $elapsedTime, _dino.position.x :${dino.position.x}, size.x : ${size.x} ,  _dinoWorld.size.x :${dinoLand.size.x}");
      log("position.x + size.x :${dino.position.x + size.x}, cactus x :${600}");
      log("currentFrame : $currentFrame, dino.feverEndFrame :${dino.feverEndFrame}, ");
    }

    logI += 1;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (gameState == GameState.beforeStart) {
      gameState = GameState.play;
    } else if (gameState == GameState.play ||
        gameState == GameState.fever ||
        gameState == GameState.invulnerable) {
      if (dino.speedY == 0) {
        dino.speedY += dino.jumpSpeed;
      }
    } else if (gameState == GameState.gameover) {
      if (overlays.isActive(Constants.overlayName)) {
        overlays.remove(Constants.overlayName);
      } else {
        gameState = GameState.beforeStart;
      }
    }
  }
}
