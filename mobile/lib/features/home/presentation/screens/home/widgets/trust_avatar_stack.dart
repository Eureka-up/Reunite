import 'package:flutter/material.dart';

class TrustAvatarStack extends StatelessWidget {
  const TrustAvatarStack({super.key});
  @override
  Widget build(BuildContext context) {
    const colors = [Color(0xFFFF8A65), Color(0xFF4DB6AC), Color(0xFF42A5F5), Color(0xFFFFB74D)];
    const labels = ['A', 'م', 'S', 'ن'];
    return SizedBox(
      height: 28,
      width: 78,
      child: Stack(
        children: List.generate(4, (i) {
          return Positioned(
            left: i * 18,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: colors[i],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Center(
                child: Text(labels[i], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
              ),
            ),
          );
        }),
      ),
    );
  }
}
