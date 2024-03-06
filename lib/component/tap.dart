import 'dart:async';
import 'package:flame/components.dart';

import '../shared/config.dart';
import 'game.dart';

class Tap extends SpriteComponent with HasGameRef<FlappyGame> {
  Tap();
  @override
  FutureOr<void> onLoad() {
    sprite = game.getGameSprite(
      SpritesPositions.tapX,
      SpritesPositions.tapY,
      SpriteDimensions.tapW,
      SpriteDimensions.tapH,
    );
    position = Vector2(
      game.size.x / 2,
      game.size.y / 4,
    );
    anchor = Anchor.center;
    scale *= 3.5;
    return super.onLoad();
  }
}
