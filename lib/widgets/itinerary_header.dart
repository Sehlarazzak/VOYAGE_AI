import 'package:flutter/material.dart';

class ItineraryHeader extends StatelessWidget{
  final String destination;
  final int days;
  final int travellers;
  final String budget;
  final String? imageUrl;
  final String province;
  final String travelStyle;

  const ItineraryHeader({
    super.key,
    required this.destination,
    required this.travellers,
    required this.days,
    required this.budget,
    this.imageUrl,
    required this.province,
    required this.travelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 375,
      width: double.infinity,
      child: Stack(
        children: [

          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
              child: imageUrl !=null ?
              Image.network(imageUrl!,
              fit: BoxFit.cover,
              ) : 
              Image.asset('assets/images/lahore.jpg',
              fit: BoxFit.cover,
              ),
            ),
          ),

          // =========================
          // DARK OVERLAY
          // =========================

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.15),
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0.80),
                  ],
                ),
              ),
            ),
          ),

          // =========================
          // CONTENT ON IMAGE
          // =========================

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // TOP ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      // BACK BUTTON
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.35),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 19,
                          ),
                        ),
                      ),

                      // AI GENERATED
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.white24,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Text(
                              '✨',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),

                            SizedBox(width: 6),

                            Text(
                              'AI Generated',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // =========================
                  // COMFORT + LOCATION
                  // =========================

                  Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF176FE5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          travelStyle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                       Text(
                        '$province',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // DESTINATION
                  Text(
                    destination,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // =========================
                  // INFO BADGES
                  // =========================

                  Row(
                    children: [

                      _InfoBadge(icon: Icons.calendar_today_outlined, text: '$days Days'),

                      const SizedBox(width: 8),

                      _InfoBadge(icon: Icons.people_outline, text: '$travellers Travelers'),

                      const SizedBox(width: 8),

                      _InfoBadge(icon: Icons.attach_money, text: budget),
                    ],
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

class _InfoBadge extends StatelessWidget {
  const _InfoBadge({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.50),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 14,
          ),

          const SizedBox(width: 5),

          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}