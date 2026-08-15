import 'package:flutter/material.dart';

class CustomElevatedbutton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const CustomElevatedbutton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1E6AE1),
            foregroundColor: Color(0xFF94A3B8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(16),
            )
          ),
           child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
              ),
        
              if(icon != null) ...[
                const SizedBox(width: 8),
                Icon(icon),
              ]
            ],
           ),
           ),
      ),
    );
  }
}