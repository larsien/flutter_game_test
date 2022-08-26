import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter_game_test/dino_game.dart';
import 'package:flutter_game_test/game_state.dart';

class DinoBackground extends SpriteComponent with HasGameRef<DinoGame> {
  // late Sprite _floorSprite;
  DinoBackground() : super();
  final double xSize = 2400;
  final double ySize = 300;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    final image = await Flame.images.load('galaxy.png');
    sprite = Sprite(
      image,
    );
    // Sprite(image,
    //     srcPosition: Vector2(2, 104), srcSize: Vector2(xSize, ySize));
    // sprite = await gameRef.loadSprite(Constants.spriteAsset);
    // position =
    anchor = Anchor.topLeft;
    position = Vector2(0, 0);
    size = Vector2(xSize, gameRef.size.y / 2);
    // position = Vector2(0, gameRef.size.y - sprite!.srcSize.y);
    log("DinoWorld onLoad : $position, ${gameRef.size}");
  }

  @override
  void update(double dt) {
    super.update(dt);
    switch (gameState) {
      case GameState.beforeStart:
        position.x = 0;
        break;
      case GameState.invulnerable:
      case GameState.fever:
      case GameState.play:
        position.x -= (gameRef.gameSpeed * 0.2);
        if (position.x < (-size.x)) {
          position.x = gameRef.size.x;
        }
        break;
      case GameState.gameover:
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
