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

    var angleDelta = ship.angle - angle;

    if (angleDelta > pi) {
      print('angleDelta is greater than pi: $angleDelta');

      var shortAngle = (2 * pi - angleDelta);
      print('proposed angle: $angle');

      print('short angle $shortAngle');
    } else if (angleDelta < -pi) {
      print('angleDelta is less than -pi $angleDelta');
      print('proposed angle: $angle');
      var shorterAngle = (2 * pi - angle) * -1;
      print('shorter angle $shorterAngle');
      print('ship angle ${ship.angle}');
      angle = shorterAngle;
    }

    // rotate to angle
    ship.addEffect(RotateEffect(angle: angle, speed: 3));
    // print(degrees(angle));
  }
}
