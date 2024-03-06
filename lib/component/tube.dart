import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../shared/config.dart';
import 'game.dart';

class Tube extends SpriteComponent with HasGameRef<FlappyGame> {
  final double startX;
  final bool isBottom;
  final double sizeY;

  Tube({required this.startX, required this.isBottom, required this.sizeY});
  @override
  FutureOr<void> onLoad() {
    sprite = game.getGameSprite(
      SpritesPositions.tubeX,
      SpritesPositions.tubeY,
      SpriteDimensions.tubeWidth,
      SpriteDimensions.tubeHeight,
    );
    position = Vector2(
      startX,
      isBottom
          ? game.camera.visibleWorldRect.bottom - SpriteDimensions.bottomHeight
          : game.camera.visibleWorldRect.top,
    );
    angle = isBottom ? 0 : -pi;
    scale = Vector2(2, 1);
    size.y = sizeY;
    anchor = Anchor.bottomCenter;
    add(RectangleHitbox(collisionType: CollisionType.passive));
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
