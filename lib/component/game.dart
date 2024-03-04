import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/component/bird.dart';
import 'package:flappy_bird/component/wall.dart';
import 'package:flappy_bird/shared/config.dart';

class FlappyGame extends FlameGame with TapCallbacks {
  double currentWallX = 0.0;
  late Bird bird;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await Flame.images.load('sprite.png');
    debugMode = true;
    camera.backdrop = SpriteComponent(
      sprite: getGameSprite(
        0,
        0,
        SpriteDimensions.horizontWidth,
        SpriteDimensions.horizontHeight,
      ),
      size: size,
    );
    bird = Bird();
    camera.follow(bird, horizontalOnly: true);
    world.add(bird);
    add5Wall(camera.visibleWorldRect.left);
  }

  @override
  void update(double dt) {
    //generate new wall
    if (currentWallX - 200 < camera.visibleWorldRect.right) {
      add5Wall(currentWallX);
    }
    super.update(dt);
  }

  void add5Wall(double startX) {
    for (int i = 0; i < 5; i++) {
      world.add(Wall(startX: startX + i * SpriteDimensions.bottomWidth));
      if (i == 4) currentWallX = startX + 5 * SpriteDimensions.bottomWidth;
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
    bird.jump();
  }
}
