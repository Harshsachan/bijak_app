import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData leadingIcon;
  final Function()? leadingOnPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.leadingIcon,
    this.leadingOnPressed,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(leadingIcon, color: Colors.white),
        onPressed: leadingOnPressed ?? () => Navigator.of(context).pop(),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
