import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter_game_test/dino_game.dart';
import 'package:flutter_game_test/game_state.dart';

class DinoLand extends SpriteComponent with HasGameRef<DinoGame> {
  // late Sprite _floorSprite;
  DinoLand() : super();
  final double xSize = 2400;
  final double ySize = 50;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    final image = await Flame.images.load('land.png');
    sprite = Sprite(
      image,
    );
    // Sprite(image,
    //     srcPosition: Vector2(2, 104), srcSize: Vector2(xSize, ySize));
    // sprite = await gameRef.loadSprite(Constants.spriteAsset);
    // position =
    // anchor = Anchor.center;
    anchor = Anchor.bottomLeft;
    position = Vector2(0, gameRef.size.y / 2);
    size = Vector2(xSize, ySize);
    // position = Vector2(0, gameRef.size.y - sprite!.srcSize.y);
    log("DinoWorld onLoad : $position, ${gameRef.size}");
  }

  @override
  void update(double dt) {
    super.update(dt);
    switch (gameState) {
      case GameState.beforeStart:
        // position.x = 0;
        position.x = 0;
        break;
      case GameState.invulnerable:
      case GameState.fever:
      case GameState.play:
        //앞으로 이동
        position.x -= gameRef.gameSpeed;
        //길이의 끝 까지 오면 빈공간(gameRef.size.x) 보인 후 위치 리셋
        if (position.x < (-size.x + gameRef.size.x)) {
          position.x = 0;
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
