import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'component/game.dart';
import 'game_vmd.dart';

Future main() async {
  Get.put(GameVmd());
  final vmd = Get.find<GameVmd>();
  runApp(
    GetMaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            const GameWidget.controlled(
              gameFactory: FlappyGame.new,
            ),
          ],
        ),
      ),
    ),
  );
}
