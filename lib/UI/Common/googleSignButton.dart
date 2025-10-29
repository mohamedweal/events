import 'package:events/UI/design/design.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,

        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        side: const BorderSide(
          color: AppColors.lightPrimary,
          width: 1.0,
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // **IMPORTANT: Replace 'assets/google_logo.png' with your actual asset path.**
          Image.asset(
            'assets/images/google_logo.png',
            height: 24,
          ),
          const SizedBox(width: 12),
           Text(
            'Login With Google',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.lightPrimary,
              fontFamily: GoogleFonts.inter().fontFamily,
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}