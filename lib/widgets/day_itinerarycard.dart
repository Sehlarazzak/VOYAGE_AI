import 'package:flutter/material.dart';
import 'package:first_project/widgets/itinerary_period.dart';

class DayItinerarycard extends StatelessWidget{
  final String title;
final int dayNumber;

final String morning;
final String morningTime;
final String morningFood;

final String afternoon;
final String afternoonTime;
final String afternoonFood;

final String evening;
final String eveningTime;
final String eveningFood;

final String estimatedCost;

  const DayItinerarycard({
    super.key,
  required this.title,
  required this.dayNumber,

  required this.morning,
  required this.morningTime,
  required this.morningFood,

  required this.afternoon,
  required this.afternoonTime,
  required this.afternoonFood,

  required this.evening,
  required this.eveningTime,
  required this.eveningFood,

  required this.estimatedCost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                  color: const Color(0xFF1763D6),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Center(
                  child: Text(
                    '$dayNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

               const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF071226),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Full-Day Plan',
                      style: TextStyle(
                        color: Color(0xFF8A98AD),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2FF),
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  children: [
                    Text(
                      estimatedCost,
                      style: const TextStyle(
                        color: Color(0xFF1763D6),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 2),

                    const Text(
                      'est./person',
                      style: TextStyle(
                        color: Color(0xFF8A98AD),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ),

          const Divider(
            height: 1,
            color: Color(0xFFEFF2F6),
          ),

          _TextSection(
            icon: Icons.free_breakfast_outlined,
            iconColor: const Color(0xFFFFA000),
            label: 'MORNING',
            time: morningTime,
            description: morning,
            food: morningFood,
          ),

          // AFTERNOON
          _TextSection(
            icon: Icons.wb_sunny_outlined,
            iconColor: const Color(0xFF2878E8),
            label: 'AFTERNOON',
            time: afternoonTime,
            description: afternoon,
            food: afternoonFood,
          ),

          // EVENING
          _TextSection(
            icon: Icons.nightlight_outlined,
            iconColor: const Color(0xFF8957F5),
            label: 'EVENING',
            time: eveningTime,
            description: evening,
            food: eveningFood,
          ),


        ],
      ),
    );
  }
}

class _TextSection extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String time;
  final String description;
  final String food;

  const _TextSection({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.time,
    required this.description,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ICON
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),

          const SizedBox(width: 14),

          // CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  label,
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF8A98AD),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF071226),
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 7),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🍴 ',
                      style: TextStyle(fontSize: 13),
                    ),
                    Expanded(
                      child: Text(
                        'Try: $food',
                        style: const TextStyle(
                          color: Color(0xFF536078),
                          fontSize: 13,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}