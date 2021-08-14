import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'get_angle.dart';
import 'dart:math';

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
    // print(tapPosition.runtimeType);
    var angle = getAngle(ship.position, tapPosition);
    // move immediately to angle
    // ship.angle = angle;
    //

    // smoothly turn  ship

    if (ship.angle - angle < -pi) {
      angle = (2 * pi - angle) * -1;
    }

    // rotate to angle
    // ship.addEffect(RotateEffect(angle: angle, speed: 3));

    // rotate to angle with animation curve easeInOutBack
    // ship.addEffect(
    //     RotateEffect(angle: angle, speed: 3, curve: Curves.easeInOutBack));

    // decelerate
    ship.addEffect(
        RotateEffect(angle: angle, speed: 3, curve: Curves.decelerate));
  }
}
