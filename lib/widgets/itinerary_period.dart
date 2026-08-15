import 'package:flutter/material.dart';

class ItineraryPeriod extends StatelessWidget{
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const ItineraryPeriod({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.10),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            Text(
              description,
              style: const TextStyle(
                color: Color(0xFF071226),
                fontSize: 16,
                height: 1.45,
              ),
            ),
          ],
        ),
        ),
      ],
    ),
    );
  }
}