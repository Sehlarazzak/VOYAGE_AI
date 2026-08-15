import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget{
  final TextEditingController controller;
  final String? label;
  final String hinttext;
  final IconData prefixicon;
  final IconData? suffixicon;
  final VoidCallback? onSuffixPressed;
  final String? Function(String?)? validator;
  final TextInputType keyboardtype;
  final bool obscuretext;

  const CustomTextfield({
    super.key,
    this.label,
    required this.controller,
    required this.hinttext,
    required this.prefixicon,
    this.suffixicon,
    this.onSuffixPressed,
    this.validator,
    this.keyboardtype = TextInputType.text,
    this.obscuretext = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardtype,
      obscureText: obscuretext,
      validator: validator,

      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: const TextStyle(
          color: Color(0xFFB8C5D6),
          fontSize: 16,
        ),

        prefixIcon: Icon(
          prefixicon,
          color: const Color(0xFF8FA5C3),
        ),

        suffixIcon: suffixicon != null? 
        IconButton(onPressed: onSuffixPressed, icon: Icon(suffixicon, color: Color(0xFF8FA5C3),),)
        : null,
        
        filled: true,
        fillColor: const Color(0xFFF7F9FC),

        contentPadding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color(0xFF4F8EF7),
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          )
        )


      ),

    );
  }
}