import 'package:flutter/material.dart';

class CustomTripcard extends StatelessWidget{
  final String imagePath;
  final String destination;
  final String difficulty;
  final String  people;
  final String duration;
  final String plannedDate;
  final VoidCallback onTap;

  const CustomTripcard({
    super.key,
    required this.imagePath,
    required this.destination,
    required this.difficulty,
    required this.people,
    required this.duration,
    required this.plannedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 135,
                height: 135,
                child: imagePath.startsWith('http') ?
                Image.network(imagePath,
                fit: BoxFit.cover,
                ) : Image.asset(imagePath,
                fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(
                      destination,
                      overflow: TextOverflow.ellipsis,
            maxLines: 1,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F1C35),
                      ),
                    ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F7FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        difficulty,
                        style: const TextStyle(
                          color: Color(0xFF1E6AE1),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Icon(Icons.people_outline,
                    size: 16,
                    color: Color(0xFFF59E0B),
                    ),

                    const SizedBox(width: 5),

                    Text(
                      people,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Icon(Icons.calendar_today_outlined,
                    size: 15,
                    color: Color(0xFF1E6AE1),
                    ),

                    Text(
                      duration,
                      style: const TextStyle(
                        color: Color(0xFF6B7280)
                      ),
                    ),

                    const Spacer(),

                    Text(
                      plannedDate,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 16,
                      ),
                    ),
                    


                  ],
                ),
              ],
            ),
            ),
          ],
        ),

      ),
    );
  }
}

