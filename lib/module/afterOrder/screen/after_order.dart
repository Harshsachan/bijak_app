import 'package:Bijak/module/afterOrder/controller/after_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:confetti/confetti.dart';

class AfterOrder extends StatelessWidget {
  const AfterOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AfterOrderController controller = Get.put(AfterOrderController());

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.check_circle, size: 100, color: Colors.green),
                  SizedBox(height: 16.0),
                  Text(
                    'Order Placed Successfully!',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ConfettiWidget(
              confettiController: controller.confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: true,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
              createParticlePath: controller.drawStar,
            ),
          ],
        ),
      ),
    );
  }
}
