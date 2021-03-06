import 'package:flutter/material.dart';

class CustomRoundButton extends StatefulWidget {
  final Function onTap;
  final IconData icon;
  final Color color;

  const CustomRoundButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color = Colors.black,
  });

  @override
  State<CustomRoundButton> createState() => _CustomRoundButtonState();
}

class _CustomRoundButtonState extends State<CustomRoundButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: widget.color)),
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          widget.icon,
          size: 14,
          color: widget.color,
        ),
      ),
    );
  }
}
