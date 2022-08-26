import 'dart:async';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game_test/bottom_panel.dart';
import 'package:flutter_game_test/dino_game.dart';
import 'package:screenshot/screenshot.dart';

void main() async {
  runApp(const MaterialApp(home: SplashScreen()));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SplashScreen2())));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ms.Flip, MrFolder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            body: Container(
                foregroundDecoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/splash.png"),
                        fit: BoxFit.fill)))));
  }
}

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2();
}

class _SplashScreen2 extends State<SplashScreen2> {
  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyApp())));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ms.Flip, MrFolder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            body: Container(
                foregroundDecoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/splash2.png"),
                        fit: BoxFit.fill)))));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final game = DinoGame();
    return MaterialApp(
      title: 'Ms.Flip, MrFolder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: Screenshot(
        controller: screenshotController,
        child: Stack(children: [
          GameWidget(
            game: game,
            overlayBuilderMap: {
              'PauseMenu': (BuildContext context, DinoGame game) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(height: 150),
                    Center(
                      child: SizedBox(
                        height: 100,
                        child: Text('축하합니다!',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                );
              },
            },
          ),
          BottomPanel(screenshotController: screenshotController),
        ]),
      )),
    );
  }
}
