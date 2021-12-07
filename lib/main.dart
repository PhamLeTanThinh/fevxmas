import 'package:christmas_form/api/sheets/user_sheets_api.dart';
import 'package:christmas_form/page/audio_play.dart';
import 'package:christmas_form/page/create_sheets_page.dart';
import 'package:christmas_form/page/present_event.dart';
import 'package:flutter/material.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await UserSheetApi.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'ĐÓN GIÁNG SINH CÙNG NHÀ VÊ';
  
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    // color: Colors.white,
    theme: ThemeData(
      errorColor: Colors.yellow,
     textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: Colors.white,
        selectionHandleColor: Colors.white,
        
     ),
   ),
    // home: CreateSheetsPage(),
    home: Present(),
    // home: AudioPlayerWithLocalAssets(),
  );
}

