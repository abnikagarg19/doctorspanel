import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' as riv;
import 'package:rive/rive.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AiPage extends StatefulWidget {
  AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  var animationLink = 'assets/images/ai2.riv';
  StateMachineController? stateMachineController;
  Artboard? artboard;
  SMIBool? isIdle;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer = AudioPlayer();
    rootBundle.load(animationLink).then((value) async {
      await RiveFile.initialize();
      final file = RiveFile.import(value);

      final art = file.mainArtboard;
      //use for controlling different actions
      stateMachineController =
          StateMachineController.fromArtboard(art, "State Machine 1");

      if (stateMachineController != null) {
        art.addController(stateMachineController!);

        stateMachineController!.inputs.forEach((element) {
          if (element.name == "idle") {
            isIdle = element as SMIBool;
          } else {
            print(element.name);
          }
        });
      }
      artboard = art;
//hands!.fire();
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playMusic();
    });
  }

  Future<void> _playMusic() async {
     await _audioPlayer.setAsset("images/audio.wav" // your song in assets/audio
        );
    await _audioPlayer.setVolume(0);
    Future.delayed(
      Duration(milliseconds: 300),
    );
   
    _playvulumeMusic();
  }

  Future<void> _playvulumeMusic() async {
    _audioPlayer.setVolume(1.0);
    await _audioPlayer.play();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            if (artboard != null)
              GestureDetector(
                onTap: () {
                  _playMusic();
                },
                child: Container(
                  height: 220,
                  width: 220,
                  child: riv.Rive(fit: BoxFit.cover, artboard: artboard!),
                ),
              ),
            SizedBox(
              height: 80,
            ),
            // Typing animation
            AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TyperAnimatedText(
                  "Take a gentle breath with me and notice how, in this moment, your body is already supporting you. You’ve faced these feelings before and made it through, let’s explore the strength you used then so we can call on it again now.",
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(
                    color: Color.fromRGBO(75, 75, 75, 1),
                    fontSize: 20,
                    fontFamily: "SWItal",
                  ),
                  curve: Curves.linear,
                  speed: const Duration(milliseconds: 65), // typing speed
                ),
              ],
            ),
            // Text(
            //  "Take a gentle breath with me and notice how, in this moment, your body is already supporting you.",
            //   style: TextStyle(
            //     color: Color.fromRGBO(75, 75, 75, 1),
            //     fontSize: 20,
            //     fontFamily: "SWItal",
            //   ),
            //   textAlign: TextAlign.center,
            // ),
          ],
        ),
      ),
    );
  }
}
