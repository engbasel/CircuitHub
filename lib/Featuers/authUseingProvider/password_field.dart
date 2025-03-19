import 'package:flutter/material.dart';
import 'package:store/Core/Widget/custom_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.onSaved,
    this.focusNode, // Accept a focusNode
    this.onFieldSubmitted,
    this.validator,
    required this.hintText,
    this.controller, // Handle onFieldSubmitted for form navigation
  });

  final void Function(String?)? onSaved;
  final FocusNode? focusNode; // FocusNode for this field
  final void Function(String)? onFieldSubmitted; // OnFieldSubmitted callback
  final String? Function(String?)? validator;
  final String hintText;
  final TextEditingController? controller;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obobscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obobscureText: obobscureText,
      onSaved: widget.onSaved,
      hintText: widget.hintText,
      focusNode: widget.focusNode, // Pass the focusNode down
      onFieldSubmitted: widget.onFieldSubmitted, // Pass the onFieldSubmitted
      textInputType: TextInputType.visiblePassword,
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            obobscureText = !obobscureText;
          });
        },
        child: Icon(
          obobscureText ? Icons.visibility_off : Icons.remove_red_eye,
          color: const Color(0XFFC9CECF),
        ),
      ),
    );
  }
}
