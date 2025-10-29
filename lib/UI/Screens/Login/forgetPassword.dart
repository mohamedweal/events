import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class forgetPassword extends StatelessWidget {
  const forgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forget Password",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/forgetPassword.png", fit: BoxFit.cover),
            SizedBox(height: 24,),
            ElevatedButton(onPressed: (){}, child: Text("Reset Password")),
          ],
        ),
      ),
    );
  }
}
