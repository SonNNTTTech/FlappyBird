import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/component/bird.dart';
import 'package:flappy_bird/component/ground.dart';
import 'package:flappy_bird/component/tap.dart';
import 'package:flappy_bird/component/tube.dart';
import 'package:flappy_bird/shared/config.dart';
import 'package:flappy_bird/shared/enum.dart';

class FlappyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  double groundTracker = 0.0;
  late Bird bird;
  late Tap tap;
  GameState gameState = GameState.pending;
  double tubeTracker = 0.0;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await Flame.images.load('sprite.png');
    // debugMode = true;
    camera.backdrop = SpriteComponent(
      sprite: getGameSprite(
        0,
        0,
        SpriteDimensions.horizontalWidth,
        SpriteDimensions.horizontalHeight,
      ),
      size: size,
    );
    bird = Bird();
    camera.follow(bird, horizontalOnly: true);
    world.add(bird);
    tap = Tap();
    world.add(tap);
    add5Ground(camera.visibleWorldRect.left);
  }

  @override
  void update(double dt) {
    //generate new ground
    if (groundTracker - 200 < camera.visibleWorldRect.right) {
      add5Ground(groundTracker);
    }
    addTube();
    if (tap.isMounted) tap.position.x = bird.position.x + 12;
    super.update(dt);
  }

  void addTube() {
    if (gameState != GameState.playing) return;
    if (camera.visibleWorldRect.right > tubeTracker + size.x) {
      tubeTracker = camera.visibleWorldRect.right;
      final sizeY = 80 + Random().nextDouble() * size.y / 2;
      world.add(
        Tube(
            startX: camera.visibleWorldRect.right,
            isBottom: true,
            sizeY: sizeY),
      );
      world.add(
        Tube(
            startX: camera.visibleWorldRect.right,
            isBottom: false,
            sizeY: size.y - sizeY - size.y / 3.5),
      );
    }
  }

  void add5Ground(double startX) {
    for (int i = 0; i < 5; i++) {
      world.add(Ground(startX: startX + i * SpriteDimensions.bottomWidth));
      if (i == 4) groundTracker = startX + 5 * SpriteDimensions.bottomWidth;
    }
  }

  Sprite getGameSprite(double x, double y, double width, double height) {
    return Sprite(
      Flame.images.fromCache('sprite.png'),
      srcPosition: Vector2(x, y),
      srcSize: Vector2(width, height),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (gameState == GameState.pending || gameState == GameState.pause) {
      gameState = GameState.playing;
      world.remove(tap);
    }
    bird.jump();
  }
}
