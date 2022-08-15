import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flutter_game_test/dino_player.dart';
import 'package:flutter_game_test/game_state.dart';
import 'package:flutter_game_test/option.dart';

import 'constsnts.dart';

class Button extends SpriteComponent with HasGameRef, TapCallbacks {
  // late Sprite _floorSprite;
  Button() : super();
  final double xSize = 2400;
  final double ySize = 24;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // final image = await Flame.images.load(Constants.finn);
    // sprite =
    // Sprite(image, srcPosition: Vector2(2, 104), srcSize: Vector2(2400, 24));
    // Sprite(image,
    //     srcPosition: Vector2(2, 104), srcSize: Vector2(xSize, ySize));
    sprite = await gameRef.loadSprite(Constants.finn);
    // position =
    // anchor = Anchor.center;
    position = Vector2(0, gameRef.size.y / 2);
    size = Vector2(gameRef.size.x, gameRef.size.y / 2);
    // position = Vector2(0, gameRef.size.y - sprite!.srcSize.y);
    print("Button onLoad : $position, ${gameRef.size}");
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
