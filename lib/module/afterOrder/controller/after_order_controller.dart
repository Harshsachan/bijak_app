import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AfterOrderController extends GetxController {
  final ConfettiController confettiController = ConfettiController();

  @override
  void onInit() {
    super.onInit();
    startConfetti();
  }

  void startConfetti() {
    confettiController.play();
    Timer(const Duration(seconds: 2), () {
      confettiController.stop();
    });
    // Delay before navigating back to the main screen
    Timer(const Duration(seconds: 2), () {
      Get.back();
    });
  }

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }
}
