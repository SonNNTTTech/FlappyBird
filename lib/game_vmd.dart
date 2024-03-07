import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flappy_bird/component/game.dart';

import 'widget/dialog_wrapper.dart';

class GameVmd extends GetxController {
  late FlappyGame game;
  final score = 0.obs;

  void gameOver() {
    Get.dialog(
      Dialog(
        child: DialogWrapper(
          child: Wrap(
            direction: Axis.vertical,
            children: [
              const Text(
                "Game Over",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("Your score is ${score.value}"),
              ElevatedButton(
                onPressed: newGame,
                child: const Text("New game"),
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void newGame() {
    Get.back();
    score.value = 0;
    game.newGame();
  }
}
