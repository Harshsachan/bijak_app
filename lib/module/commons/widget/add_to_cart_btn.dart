import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;

  AddToCartButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const AutoSizeText('Add to cart', maxLines: 1),
    );
  }
}
