import 'package:vector_math/vector_math_64.dart';
import 'dart:math';

/// calculate angle between two Vector points, such as a sprite position
/// and a tap position in Flutter Flame. 0 degrees points straight up.
double getAngle(Vector2 spritePosition, Vector2 tapPosition) {
  bool tapAboveSprite = spritePosition.y > tapPosition.y;
  bool tapAtSpriteHeight = spritePosition.y == tapPosition.y;
  bool tapLeftOfSprite = spritePosition.x > tapPosition.x;
  bool tapSpriteHorizCenter = spritePosition.x == tapPosition.x;

  var opposite = (tapPosition.y - spritePosition.y).abs();
  var adjacent = (spritePosition.x - tapPosition.x).abs();
  // print('opposite = $opposite, adjacent = $adjacent');

  var angle = degrees(atan(opposite / adjacent));

  if (tapAtSpriteHeight) {
    // print('tap at height');

    if (tapLeftOfSprite) {
      angle = 270;
      return radians(angle);
    } else {
      // print('set to 90 degrees');
      angle = 90;
      return radians(angle);
    }
  }

  if (tapLeftOfSprite && !tapSpriteHorizCenter) {
    // print('tapped to the left of sprite');
    // print('original angle $angle');
    angle += 90;
    if (!tapAboveSprite && !tapAtSpriteHeight) {
      // print(270 - (angle - 90));
      angle = 270 - (angle - 90);
      return radians(angle);
    } else if (tapAboveSprite && !tapAtSpriteHeight) {
      angle += 180;
      return radians(angle);
    }
  }

  if (!tapLeftOfSprite && !tapSpriteHorizCenter) {
    if (!tapAboveSprite && !tapAtSpriteHeight) {
      // print('right, below');
      angle += 90;
    } else {
      angle = 90 - angle;
    }
  }

  if (tapSpriteHorizCenter && !tapAboveSprite) {
    angle = 180;
  } else if (tapSpriteHorizCenter && tapAboveSprite) {
    angle = 0;
  }
  return radians(angle);
}
