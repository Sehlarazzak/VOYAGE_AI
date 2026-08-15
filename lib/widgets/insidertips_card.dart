import 'package:flutter/material.dart';

class InsiderTipsCard extends StatelessWidget {
  final List<String> tips;

  const InsiderTipsCard({
    super.key,
    required this.tips,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: const Color(0xFF151F32),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF29364D),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.explore,
                color: Color(0xFF3D9CFF),
                size: 23,
              ),

              const SizedBox(width: 8),

              const Text(
                'Local Insider Tips',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          ...tips.map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.star,
                    color: Color(0xFF3D9CFF),
                    size: 16,
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      tip,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}