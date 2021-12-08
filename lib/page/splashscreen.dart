import 'dart:async';

import 'package:christmas_form/model/hex_color.dart';
import 'package:christmas_form/page/present_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Color red = HexColor("#AA3A38");
  final Color green = HexColor("#2F7336");

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Present())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [red, green])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.asset('assets/fev.png'),
                    Text(
                      "Chúc bạn và gia đình có một mùa giáng sinh an lành",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SpinKitPumpingHeart(
                  color: Colors.white,
                  size: 80,
                )
              ],
            )),
      ),
    );
  }
}
