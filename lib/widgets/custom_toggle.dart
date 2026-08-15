


import 'package:flutter/material.dart';

class CustomToggle extends StatelessWidget {
  final bool islogin;
  final Function(bool) onChanged;

  const CustomToggle ({
    super.key,
    required this.islogin,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(30),
          ),
        
          child: Row(
            children: [
              Expanded(child: GestureDetector(
                onTap: () {
                  onChanged (true);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: islogin? Color(0xFF2563EB) : Colors.transparent,
        
                    borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text('Sign In',
                    style: TextStyle(
                      color: islogin? Colors.white : const Color(0xFF64748B),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),),
                  ),
                ),
              ),
        
              Expanded(child: GestureDetector(
                onTap: () {
                  onChanged(false);
                },
                child: AnimatedContainer(
                  duration: const Duration(microseconds: 250),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: !islogin? const Color(0xFF2563EB) : Colors.transparent,
        
                    borderRadius: BorderRadius.circular(30),  
                  ),
        
                  child: Text('Create Account',
                  style: TextStyle(
                    color: !islogin? Colors.white : const Color(0xFF64748B),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

}