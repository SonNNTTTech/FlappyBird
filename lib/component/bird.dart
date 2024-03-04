import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../shared/config.dart';
import 'game.dart';

class Bird extends SpriteAnimationComponent with HasGameRef<FlappyGame> {
  Vector2 speed = Vector2(160.0, 0.0);
  final gravity = 22.0;

  @override
  void update(double dt) {
    super.update(dt);
    speed.y += gravity;
    if (speed.y < -150) {
      rotate(-pi / 4);
    } else if (speed.y > 500) {
      rotate(pi / 2);
    } else if (speed.y > 250) {
      rotate(pi / 4);
    } else {
      rotate(0);
    }
    position += speed * dt;
  }

  void rotate(double newAngle) {
    final effect = RotateEffect.to(
      newAngle,
      EffectController(duration: 0.1),
    );
    add(effect);
  }

  @override
  FutureOr<void> onLoad() {
    final sprite1 = game.getGameSprite(
      SpritesPostions.birdSprite1X,
      SpritesPostions.birdSprite1Y,
      SpriteDimensions.birdWidth,
      SpriteDimensions.birdHeight,
    );
    final sprite2 = game.getGameSprite(
      SpritesPostions.birdSprite2X,
      SpritesPostions.birdSprite2Y,
      SpriteDimensions.birdWidth,
      SpriteDimensions.birdHeight,
    );
    final sprite3 = game.getGameSprite(
      SpritesPostions.birdSprite3X,
      SpritesPostions.birdSprite3Y,
      SpriteDimensions.birdWidth,
      SpriteDimensions.birdHeight,
    );
    final sprites = [
      sprite1,
      sprite2,
      sprite3,
      sprite2,
      sprite1,
    ];
    animation = SpriteAnimation.spriteList(sprites, stepTime: 0.1);
    scale = Vector2(2.5, 2.5);
    anchor = Anchor.center;
    return super.onLoad();
  }

  void jump() {
    speed.y = -500;
  }
}
