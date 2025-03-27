// import 'package:flame/components.dart';
// import 'package:flame/effects.dart';
// import 'package:flame/text.dart';
// import 'package:flutter/material.dart';

// class FloatingScore extends PositionComponent with HasGameRef, HasPaint {
//   final int score;
//   late final TextComponent textComponent;

//   FloatingScore({
//     required this.score,
//     required Vector2 position,
//   }) {
//     this.position = position;

//     textComponent = TextComponent(
//       text: '+$score',
//       anchor: Anchor.center,
//       textRenderer: TextPaint(
//         style: const TextStyle(
//           fontSize: 24,
//           color: Colors.yellow,
//           fontWeight: FontWeight.bold,
//           shadows: [
//             Shadow(
//               blurRadius: 4,
//               color: Colors.black,
//               offset: Offset(2, 2),
//             )
//           ],
//         ),
//       ),
//     );

//     size = textComponent.size;
//   }

//   @override
//   Future<void> onLoad() async {
//     add(textComponent);

//     // Move Effect
//     final moveEffect = MoveEffect.by(
//       Vector2(0, -100),
//       EffectController(duration: 1),
//     );

//     // Fade Effect using HasPaint
//     final fadeEffect = OpacityEffect.to(
//       0,
//       EffectController(duration: 1),
//     );

//     add(moveEffect);
//     add(fadeEffect);

//     // Remove after animation completes
//     fadeEffect.onComplete = () => removeFromParent();

//     await super.onLoad();
//   }
// }
