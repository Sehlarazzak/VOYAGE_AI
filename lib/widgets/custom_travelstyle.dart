import 'package:flutter/material.dart';

class CustomTravelstyle extends StatelessWidget{
  final String title;
  final String price;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTravelstyle({
    super.key,
    required this.title,
    required this.price,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 250),
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: isSelected? iconColor.withOpacity(0.12) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected? iconColor : Colors.transparent,
          width: 2,
        ),
    
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
    
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                    ? iconColor.withOpacity(0.20) : const Color(0xFFF4F7FF),
            ),
    
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
    
          const SizedBox(height: 6),
    
          Text(price,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? iconColor : const Color(0xFF6B7280),
          ),
          ),
        ],
      ),
    ),
        );
  }
}