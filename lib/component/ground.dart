import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../shared/config.dart';
import '../shared/enum.dart';
import 'game.dart';

class Ground extends SpriteComponent with HasGameRef<FlappyGame> {
  final double startX;

  Ground({required this.startX});
  @override
  FutureOr<void> onLoad() {
    sprite = game.getGameSprite(
      SpritesPositions.bottomX,
      SpritesPositions.bottomY,
      SpriteDimensions.bottomWidth,
      SpriteDimensions.bottomHeight,
    );
    position = Vector2(
      startX,
      game.camera.visibleWorldRect.bottom - SpriteDimensions.bottomHeight,
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (game.gameState == GameState.gameOver ||
        game.gameState == GameState.pause) return;
    if (toAbsoluteRect().right < game.camera.visibleWorldRect.left &&
        toAbsoluteRect().right + 1 > game.camera.visibleWorldRect.left) {
      removeFromParent();
    }
  }
}
