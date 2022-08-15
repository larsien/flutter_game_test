import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter_game_test/button.dart';
import 'package:flutter_game_test/cactus.dart';
import 'package:flutter_game_test/dino_player.dart';
import 'package:flutter_game_test/dino_world.dart';
import 'package:flutter_game_test/game_state.dart';
import 'package:flutter_game_test/option.dart';

class DinoGame extends FlameGame
    with HasTappableComponents, HasCollisionDetection {
  final DinoPlayer dino = DinoPlayer();
  final DinoWorld _dinoWorld = DinoWorld();
  final Button _button = Button();
  final Cactus _cactus = Cactus();
  // final Camera _camera = Camera();
  @override
  Future<void> onLoad() async {
    print("test");
    // double maxSide = min(size.x, size.y);
    // print(maxSide);
    super.onLoad();

    await add(_dinoWorld);
    await add(_cactus);
    await add(dino);
    await add(_button);

    // camera.followComponent(_dinoPlayer);
    // _dinoPlayer.position = _dinoWorld.size;
    // camera.viewport = FixedResolutionViewport(size);
    // camera.followComponent(
    //   relativeOffset: Anchor.centerLeft,
    //   _dino,
    // );
  }

  int i = 0;
  double dinoMoved = 0;
  @override
  void update(double t) {
    super.update(t);
    // printDebug(t);
    // if (_dino.position.x.abs() + size.x > _dinoWorld.size.x.abs()) {
    //   // _dinoWorld.position.x = _dinoWorld.size.x - size.x;
    //   // _dino.position.x = 20;
    //   SpriteComponent newWorldcomponent = SpriteComponent();
    //   newWorldcomponent.sprite = _dinoWorld.sprite;
    //   newWorldcomponent.sprite!.srcPosition =
    //       Vector2(_dinoWorld.size.x, _dinoWorld.size.y);
    //   newWorldcomponent.sprite = _dinoWorld.sprite;
    //   _dinoWorld.add(newWorldcomponent);
    //   // gameState = GameState.pause;
    // }
    //속도는 5, 60프레임이 1초, 1초에 300픽셀 이동. 2초에 한개씩 나오게 하기
    switch (gameState) {
      case GameState.beforeStart:
        _cactus.getRandomCactus(600);
        break;
      case GameState.play:
        dinoMoved += GAME_SPEED;
        if (dinoMoved % 600 == 5) {
          _cactus.getRandomCactus(600);
        }

        // if (checkIf2CompoCollision(_dino.toRect(), _cactus.toRect())) {
        //   gameState = GameState.gameover;
        // }
        break;
      case GameState.gameover:
        break;
    }

    printDebug(t);
  }

  void printDebug(double t) {
    if (i % 120 == 0) {
      print(
          "$i, _dino.position.x :${dino.position.x}, size.x : ${size.x} ,  _dinoWorld.size.x :${_dinoWorld.size.x}");
      print(
          "_dino.position.x + size.x :${dino.position.x + size.x}, cactus x :${600}");
    }

    i += 1;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (gameState == GameState.beforeStart) {
      gameState = GameState.play;
    } else if (gameState == GameState.play) {
      dino.speedY += dino.jumpSpeed;
    } else if (gameState == GameState.gameover) {
      gameState = GameState.beforeStart;
    }
  }
}
