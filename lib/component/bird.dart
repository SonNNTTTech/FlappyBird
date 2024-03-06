// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flappy_bird/component/ground.dart';
import 'package:flappy_bird/component/tube.dart';
import 'package:flappy_bird/shared/enum.dart';

import '../shared/config.dart';
import 'game.dart';

class Bird extends SpriteAnimationComponent
    with HasGameRef<FlappyGame>, CollisionCallbacks {
  final speed = Vector2(160.0, 0.0);
  final gravity = 28.0;
  bool isGoUp = true;
  @override
  void update(double dt) {
    super.update(dt);
    if (game.gameState == GameState.gameOver ||
        game.gameState == GameState.pause) return;
    if (game.gameState == GameState.pending) {
      if (isGoUp)
        speed.y -= 5;
      else {
        speed.y += 5;
      }
      if (speed.y == -60 || speed.y == 60) {
        isGoUp = !isGoUp;
      }
    }
    if (game.gameState == GameState.playing) {
      speed.y += gravity;
      if (speed.y < -150) {
        rotate(-pi / 6);
      } else if (speed.y > 700) {
        rotate(pi / 2);
      } else if (speed.y > 350) {
        rotate(pi / 4);
      } else {
        rotate(0);
      }
    }
    position += speed * dt;
  }

  void rotate(double newAngle) {
    if (newAngle == angle) return;
    final effect = RotateEffect.to(
      newAngle,
      EffectController(duration: 0.1),
    );
    add(effect);
  }

  @override
  FutureOr<void> onLoad() {
    final sprite1 = game.getGameSprite(
      SpritesPositions.birdSprite1X,
      SpritesPositions.birdSprite1Y,
      SpriteDimensions.birdWidth,
      SpriteDimensions.birdHeight,
    );
    final sprite2 = game.getGameSprite(
      SpritesPositions.birdSprite2X,
      SpritesPositions.birdSprite2Y,
      SpriteDimensions.birdWidth,
      SpriteDimensions.birdHeight,
    );
    final sprite3 = game.getGameSprite(
      SpritesPositions.birdSprite3X,
      SpritesPositions.birdSprite3Y,
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
    add(RectangleHitbox(size: size * 0.9));
    return super.onLoad();
  }

  void jump() {
    if (game.gameState == GameState.playing) speed.y = -600;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ground || other is Tube) {
      game.gameState = GameState.gameOver;
      playing = false;
    }
    super.onCollision(intersectionPoints, other);
  }
}
