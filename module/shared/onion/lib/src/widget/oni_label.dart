import 'package:flutter/material.dart';
import 'package:onion/onion.dart';

class OniLabel extends StatelessWidget {
  final String label;
  final Color color;

  const OniLabel({
    required this.label,
    this.color = OniColor.flamingo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(4),
      child: Text(
        label,
        style: OniTextStyle.caption.copyWith(color: OniColor.white),
      ),
    );
  }
}
