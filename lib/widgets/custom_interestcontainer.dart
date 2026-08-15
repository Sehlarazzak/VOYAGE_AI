import 'package:flutter/material.dart';

class CustomInterestcontainer extends StatelessWidget{
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomInterestcontainer({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: isSelected? const Color(0xFF1E6AE1) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected? const Color(0xFF1E6AE1) : const Color(0xFFE5E7EB),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected? Colors.white : const Color(0xFF475569), 
            ),

            const SizedBox(width: 12),

            Expanded(child: Text(
              title,
              style: TextStyle(
                fontSize: 17,
          fontWeight: FontWeight.w600,
          color: isSelected
              ? Colors.white
              : const Color(0xFF334155),
              ),
            ),
            ),

            if(isSelected) 
            const Icon(Icons.check_circle,
            color: Colors.white,
            size: 22,
            ),
          ],
        ),
        ),
    );
  }
}