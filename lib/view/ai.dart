// import 'package:just_audio/just_audio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:rive/rive.dart' as riv;
// import 'package:rive/rive.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';

// class AiPage extends StatefulWidget {
//   AiPage({super.key});

//   @override
//   State<AiPage> createState() => _AiPageState();
// }

// class _AiPageState extends State<AiPage> {
//   var animationLink = 'assets/images/boothai.riv';
//   StateMachineController? stateMachineController;
//   Artboard? artboard;
//   SMIBool? isIdle;
//   late AudioPlayer _audioPlayer;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _audioPlayer = AudioPlayer();
//     rootBundle.load(animationLink).then((value) async {
//       await RiveFile.initialize();
//       final file = RiveFile.import(value);

//       final art = file.mainArtboard;
//       //use for controlling different actions
//       stateMachineController =
//           StateMachineController.fromArtboard(art, "State Machine 1");

//       if (stateMachineController != null) {
//         art.addController(stateMachineController!);

//         stateMachineController!.inputs.forEach((element) {
//           if (element.name == "idle") {
//             isIdle = element as SMIBool;
//           } else {
//             print(element.name);
//           }
//         });
//       }
//       artboard = art;
// //hands!.fire();
//       setState(() {});
//     });
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _playMusic();
//     });
//   }

//   Future<void> _playMusic() async {
//      await _audioPlayer.setAudioSource(AudioSource.file("assets/assets/images/audio.wav") // your song in assets/audio
//         );
//     await _audioPlayer.setVolume(0);
//     Future.delayed(
//       Duration(milliseconds: 300),
//     );

//     _playvulumeMusic();
//   }

//   Future<void> _playvulumeMusic() async {
//     _audioPlayer.setVolume(1.0);
//     await _audioPlayer.play();
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 40),
//         width: double.infinity,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 80,
//             ),
//             if (artboard != null)
//               GestureDetector(
//                 onTap: () {
//                   _playMusic();
//                 },
//                 child: Container(
//                   height: 300,
//                   width: 300,
//                   child: riv.Rive(fit: BoxFit.cover, artboard: artboard!),
//                 ),
//               ),
//           SizedBox(
//               height: 20,
//             ),
//             // Typing animation
//            AnimatedTextKit(
//   isRepeatingAnimation: false,
//   animatedTexts: [
//     TyperAnimatedText(
//       "Take a gentle breath with me and notice how, in this moment, your body is already supporting you.",
//       textAlign: TextAlign.center,
//       textStyle: const TextStyle(
//         color: Color.fromRGBO(75, 75, 75, 1),
//         fontSize: 20,
//         fontFamily: "SWItal",
//       ),
//       curve: Curves.linear,
//       speed: const Duration(milliseconds: 58),
//     ),
//     TyperAnimatedText(
//       "You've faced these feelings before and made it through, let's explore the strength you used then so we can call on it again now.",
//       textAlign: TextAlign.center,
//       textStyle: const TextStyle(
//         color: Color.fromRGBO(75, 75, 75, 1),
//         fontSize: 20,
//         fontFamily: "SWItal",
//       ),
//       curve: Curves.linear,
//       speed: const Duration(milliseconds: 62),
//     ),
//   ],
// )

//             // Text(
//             //  "Take a gentle breath with me and notice how, in this moment, your body is already supporting you.",
//             //   style: TextStyle(
//             //     color: Color.fromRGBO(75, 75, 75, 1),
//             //     fontSize: 20,
//             //     fontFamily: "SWItal",
//             //   ),
//             //   textAlign: TextAlign.center,
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';

class AiPage extends StatefulWidget {
  @override
  _AudioVisualizerState createState() => _AudioVisualizerState();
}

class _AudioVisualizerState extends State<AiPage>
    with SingleTickerProviderStateMixin {
  final player = AudioPlayer();
  final ffmpeg = FFmpegKit();
  double imageScale = 1.0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    playAndAnimate();
  }

  Future<void> playAndAnimate() async {
    // Load and play the audio
    await player.setAudioSource(AudioSource.file(
        "assets/assets/images/audio.wav")); // your song in assets/audio
    player.play();

    // Run FFmpeg to read amplitude data in real time
    // This is a workaround because just_audio does not expose raw samples
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) async {
      double amplitude =
          Random().nextDouble(); // Placeholder: use real FFT data here
      setState(() {
        imageScale = 1.0 + amplitude * 0.5; // Expand/shrink
      });
    });

    player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        timer?.cancel();
        setState(() {
          imageScale = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Center(
            child: AnimatedScale(
              scale: imageScale,
              duration: const Duration(milliseconds: 500),
              child: Image.asset(
                "assets/images/aicon.png",
                width: 200,
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          // Typing animation
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            child: AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TyperAnimatedText(
                  "Take a gentle breath with me and notice how, in this moment, your body is already supporting you.",
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(
                    color: Color.fromRGBO(75, 75, 75, 1),
                    fontSize: 20,
                    fontFamily: "SWItal",
                  ),
                  curve: Curves.linear,
                  speed: const Duration(milliseconds: 58),
                ),
                TyperAnimatedText(
                  "You've faced these feelings before and made it through, let's explore the strength you used then so we can call on it again now.",
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(
                    color: Color.fromRGBO(75, 75, 75, 1),
                    fontSize: 20,
                    fontFamily: "SWItal",
                  ),
                  curve: Curves.linear,
                  speed: const Duration(milliseconds: 62),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
