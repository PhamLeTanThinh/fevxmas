import 'package:christmas_form/model/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  
  
   ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);
  final Color red = HexColor("#AA3A38");
  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          minimumSize: Size.fromHeight(50),
          shape: StadiumBorder(),
        ),
        child: FittedBox(
          child: Text(
            text,
            style: GoogleFonts.playfairDisplay(fontSize: 20, color: red, fontWeight: FontWeight.bold),
          ),
        ),
        onPressed: onClicked,
      );
}
