import 'package:flutter/material.dart';
import 'package:marval/res/dimens.dart';

class InfoWidget extends StatelessWidget {
  
  const InfoWidget({
    required this.color,
    required this.text,
    required this.icon
  });

  final Color? color;
  final String text;
  final IconData? icon;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.0),
      ),
      height: 16.0,
      alignment: Alignment.center,
      child: Row(children: [
        icon == null? SizedBox() :Icon(icon,color: Colors.white, size: 12),
        Text(text,style: const TextStyle(color: Colors.white, fontSize: Dimens.font_sp10, height: 1.1))
      ]),
    );
  }
}