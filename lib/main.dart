import 'package:camera/camera.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fruitgame/game.dart';
import 'package:fruitgame/vision_detector_views/detector_views.dart';

import 'main_menu.dart';

List<CameraDescription> cameras = [];
final Changer changer = Changer();

MyGame fruitGame = MyGame();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.device.fullScreen();
  Flame.device.setPortrait();
  cameras = await availableCameras();

  runApp(const FruitPose());
}

class FruitPose extends StatelessWidget {
  const FruitPose({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          // SizedBox(
          //   height: 400,
          //   child: FaceDetectorView(),
          // ),
          SizedBox(
            height: 400,
            child: GameWidget(
              game: fruitGame ,
              overlayBuilderMap: {
                'MainMenu': (BuildContext context, MyGame game) {
                  return MainMenu(
                    gameRef: fruitGame,
                  );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}

// The main widget for this game.

class Changer extends ChangeNotifier {
  int btnPressed = -1;
  int selectedOpt = 0;

  void notify() {
    notifyListeners();
  }
}
