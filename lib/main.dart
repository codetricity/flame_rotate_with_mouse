import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'get_angle.dart';

void main() {
  var game = MyGame();
  runApp(GameWidget(game: game));
}

class MyGame extends BaseGame with TapDetector {
  SpriteComponent ship = SpriteComponent();
  Future<void> onLoad() async {
    ship
      ..sprite = await loadSprite('ship.png')
      ..size = Vector2(100, 100)
      ..position = Vector2(200, 200)
      ..anchor = Anchor.center;
    add(ship);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onTapUp(TapUpInfo tapInfo) {
    var tapPosition = tapInfo.eventPosition.game;
    print(tapPosition.runtimeType);
    var angle = getAngle(ship.position, tapPosition);
    ship.angle = angle;
    // print(degrees(angle));
  }
}
