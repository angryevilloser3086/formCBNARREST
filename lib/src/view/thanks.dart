import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThanksScreens extends StatelessWidget {
  const ThanksScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
             Text(
              "",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w500),)
          ],
        ),
      )),
    );
  }
}