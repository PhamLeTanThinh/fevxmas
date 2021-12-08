import 'package:christmas_form/main.dart';
import 'package:christmas_form/model/hex_color.dart';
import 'package:christmas_form/page/create_sheets_page.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class Present extends StatefulWidget {
  @override
  State<Present> createState() => _PresentState();
}

class _PresentState extends State<Present> {
    final Color red = HexColor("#AA3A38");
  final Color green = HexColor("#2F7336");


  AudioPlayer audioPlayer = AudioPlayer();
  late AudioCache audioCache;

  String path = 'xmas.mp3';
  bool isPlaying = false;

  playLocal() async {
    int result = await audioPlayer.play('xmas.mp3', isLocal: true);
  }

  void initState() {
    super.initState();

    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearAll();
  }

  playMusic() async {
    await audioCache.play(path);
  }

  PauseMusic() async {
    await audioPlayer.pause();
  }

  double opacityLevel = 1;
  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title, style: GoogleFonts.playfairDisplay(fontSize: 30, fontWeight: FontWeight.bold),),
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
            image: AssetImage('assets/xmas.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          )),
          // Blur Background

          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.grey.withOpacity(0),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: isPlaying == true
                              ? Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.play_arrow_sharp,
                                  color: Colors.white,
                                ),
                          iconSize: 50,
                          onPressed: () {
                            if (isPlaying == false) {
                              playMusic();
                              setState(() {
                                isPlaying = true;
                              });
                            } else if (isPlaying == true) {
                              PauseMusic();
                              setState(() {
                                isPlaying = false;
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 70),
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.all(20),
                    ),
                    child: Text(
                      'Vào đây Đăng Ký nha',
                      style: GoogleFonts.playfairDisplay(color: Colors.black, fontSize: 20,),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secAnimation,
                                  Widget child) {
                                animation = CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.bounceInOut);

                                return ScaleTransition(
                                  alignment: Alignment.center,
                                  scale: animation,
                                  child: child,
                                );
                                // return AnimatedOpacity(
                                //   opacity: opacityLevel,
                                //   duration: const Duration(milliseconds: 500),
                                //   child: child,
                                // );
                              },
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secAnimation) {
                                return CreateSheetsPage();
                                
                              }
                              )
                              );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
