import 'package:flutter/material.dart';

class IncrementDecrementRow extends StatelessWidget {
  final int cartQuantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  IncrementDecrementRow({
    required this.cartQuantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: onDecrement,
        ),
        Text('$cartQuantity'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: onIncrement,
        ),
      ],
    );
  }
}
