import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter_game_test/game_state.dart';

import 'constsnts.dart';

class Button extends SpriteComponent with HasGameRef, TapCallbacks {
  // late Sprite _floorSprite;
  Button() : super();
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // sprite =
    // Sprite(image, srcPosition: Vector2(2, 104), srcSize: Vector2(2400, 24));
    // Sprite(image,
    //     srcPosition: Vector2(2, 104), srcSize: Vector2(xSize, ySize));
    sprite = await gameRef.loadSprite(Constants.buttonImage);
    // position =
    // anchor = Anchor.center;
    position = Vector2(0, gameRef.size.y / 2);
    size = Vector2(gameRef.size.x, gameRef.size.y / 4);
    // position = Vector2(0, gameRef.size.y - sprite!.srcSize.y);
    log("Button onLoad : $position, ${gameRef.size}");
  }

  @override
  void onTapUp(TapUpEvent event) {
    // Do something in response to a tap
    switch (gameState) {
      case GameState.beforeStart:
        gameState = GameState.play;
        break;
      case GameState.play:
        break;
      case GameState.gameover:
        break;
      case GameState.fever:
        break;
      case GameState.invulnerable:
        break;
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // We don't need to set the position in the constructor, we can set it directly here since it will
    // be called once before the first time it is rendered.
    // position = gameSize / 2;
    log("gameSize : $size");
  }
}
