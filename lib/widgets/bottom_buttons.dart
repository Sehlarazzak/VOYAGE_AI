import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onRegenerate;

  const BottomButtons({
    super.key,
    required this.onSave,
    required this.onRegenerate,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          20,
          12,
          20,
          12,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [

            // GENERATE AGAIN
            Expanded(
              child: SizedBox(
                height: 62,
                child: OutlinedButton.icon(
                  onPressed: onRegenerate,
                  icon: const Icon(
                    Icons.refresh,
                    size: 21,
                  ),
                  label: const Text(
                    'Generate Again',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF071226),
                    side: const BorderSide(
                      color: Color(0xFFD9E1EE),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            // SAVE THIS TRIP
            Expanded(
              child: SizedBox(
                height: 62,
                child: ElevatedButton.icon(
                  onPressed: onSave,
                  icon: const Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                    size: 22,
                  ),
                  label: const Text(
                    'Save This Trip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1763D6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}