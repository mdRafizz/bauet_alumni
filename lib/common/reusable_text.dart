import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  final String title;
  final double? fontSize;
  final String? fontFamily;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final Color? color;
  final double? wordSpacing;

  const ReusableText(
    this.title, {
    super.key,
    this.fontSize,
    this.fontFamily,
    this.textAlign,
    this.color,
    this.fontWeight,
    this.letterSpacing,
    this.wordSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      // overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontFamily: fontFamily ?? 'poppins',
          fontWeight: fontWeight,
          color: color ?? Colors.black,
          fontSize: fontSize ?? 18,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing),
    );
  }
}
