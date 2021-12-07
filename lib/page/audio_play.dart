import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWithLocalAssets extends StatefulWidget {
  const AudioPlayerWithLocalAssets({Key? key}) : super(key: key);

  @override
  _AudioPlayerWithLocalAssetsState createState() =>
      _AudioPlayerWithLocalAssetsState();
}

class _AudioPlayerWithLocalAssetsState
    extends State<AudioPlayerWithLocalAssets> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.withOpacity(0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: isPlaying == true ? Icon(Icons.pause) : Icon(Icons.ac_unit, color: Colors.lightBlue,),
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
    );
  }
}
