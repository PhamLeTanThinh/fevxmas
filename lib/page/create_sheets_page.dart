import 'dart:ui';

import 'package:christmas_form/api/sheets/user_sheets_api.dart';
import 'package:christmas_form/main.dart';
import 'package:christmas_form/model/hex_color.dart';
import 'package:christmas_form/widget/user_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateSheetsPage extends StatelessWidget {
  final Color red = HexColor("#AA3A38");
  final Color green = HexColor("#2F7336");

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(MyApp.title, style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                red,
                green,
              ])),
        ),
      ),
      body: Builder(
          builder: (context) => Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/xmas2.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
              )),
              child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    child: SingleChildScrollView(
                    child: Column(
                      children: [
                        UserFormWidget(
                          onSavedUser: (user) async {
                            final id = await UserSheetApi.getRowCount() + 1;
                            final newUser = user.copy(id: id);

                            await UserSheetApi.insert([newUser.toJson()]);

                            final snackBar = SnackBar(
                              width: 400,
                              // padding: const EdgeInsets.symmetric(
                              //   horizontal: 30,
                              // ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              content: Text('Bạn đã đăng ký thành công',textAlign: TextAlign.center, style: GoogleFonts.playfairDisplay()),
                              backgroundColor: Colors.purple,

                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                        ),
                      ],
                    ),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                  ))
              // Form Dang Ky
              )));
}
