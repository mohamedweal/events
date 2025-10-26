import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef Validator = String? Function(String? text);
class AppFormField extends StatefulWidget {
  String label;
  IconData? icon;
  TextInputType keyboardType;
  bool isPassword;
  Validator? validator;
  TextEditingController? controller;
  int lines;

  AppFormField({
    required this.label,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.lines = 1,
    super.key});

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool secureText =false;
  @override
  void initState() {
    super.initState();
    secureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
          maxLines: widget.lines,
          controller: widget.controller,
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: Theme.of(context).colorScheme.primary,
          ),
          validator: widget.validator,
          obscureText: widget.isPassword && secureText,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
              labelText: widget.label,
              prefixIcon: widget.icon!=null ? Icon(widget.icon) : null,
              suffixIcon: widget.isPassword?InkWell(
                onTap: (){
                  setState(() {
                    secureText = !secureText;
                  });
                },
                child: Icon(
                    secureText ?
                    Icons.visibility  :
                    Icons.visibility_off
                ),
              ):null
          )
      ),
    );
  }
}