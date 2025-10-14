import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef Validator = String? Function(String? text);

class AppFormField extends StatefulWidget {
  String label;
  IconData icon;
  TextInputType keyboardType;
  bool isPassword;
  Validator? validator;
  TextEditingController? controller;
  AppFormField({
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.controller,
    super.key,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
   bool secureText = false;

 @override
  void initState() {
   secureText = widget.isPassword;
    super.initState();
  }
@override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: widget.controller,
        style: GoogleFonts.inter(
          fontSize: 16,
          color: Theme.of(context).colorScheme.primary,
        ),
        validator: widget.validator,
        obscureText: widget.isPassword && secureText,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
          suffixIcon: widget.isPassword
              ? InkWell(
                  onTap: () {
                    setState(() {
                      secureText = !secureText;
                    });
                  },
                  child: Icon(
                    secureText ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
