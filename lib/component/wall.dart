import 'dart:async';

import 'package:flame/components.dart';

import '../shared/config.dart';
import 'game.dart';

class Wall extends SpriteComponent with HasGameRef<FlappyGame> {
  final double startX;

  Wall({required this.startX});
  @override
  FutureOr<void> onLoad() {
    sprite = game.getGameSprite(
      SpritesPostions.bottomX,
      SpritesPostions.bottomY,
      SpriteDimensions.bottomWidth,
      SpriteDimensions.bottomHeight,
    );
    position = Vector2(
      startX,
      game.camera.visibleWorldRect.bottom - SpriteDimensions.bottomHeight,
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (toAbsoluteRect().right < game.camera.visibleWorldRect.left) {
      removeFromParent();
    }
    super.update(dt);
  }
}
