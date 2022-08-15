import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter_game_test/game_state.dart';
import 'package:flutter_game_test/option.dart';

import 'constsnts.dart';

class DinoWorld extends SpriteComponent with HasGameRef {
  // late Sprite _floorSprite;
  DinoWorld() : super();
  final double xSize = 2400;
  final double ySize = 24;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    final image = await Flame.images.load(Constants.spriteAsset);
    sprite =
        Sprite(image, srcPosition: Vector2(2, 104), srcSize: Vector2(2400, 24));
    // Sprite(image,
    //     srcPosition: Vector2(2, 104), srcSize: Vector2(xSize, ySize));
    // sprite = await gameRef.loadSprite(Constants.spriteAsset);
    // position =
    // anchor = Anchor.center;
    position = Vector2(0, gameRef.size.y / 2 - ySize);
    size = Vector2(xSize, 24);
    // position = Vector2(0, gameRef.size.y - sprite!.srcSize.y);
    print("DinoWorld onLoad : $position, ${gameRef.size}");
  }

  @override
  void update(double t) {
    super.update(t);
    switch (gameState) {
      case GameState.beforeStart:
        // position.x = 0;
        position.x = 0;
        break;
      case GameState.play:
        //앞으로 이동
        position.x -= GAME_SPEED;
        if (position.x < (-size.x + gameRef.size.x)) {
          position.x = 0;
        }

        break;
      case GameState.gameover:
        // position.x

        break;
    }
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    // We don't need to set the position in the constructor, we can set it directly here since it will
    // be called once before the first time it is rendered.
    // position = gameSize / 2;
    print("gameSize : $gameSize");
  }
}
