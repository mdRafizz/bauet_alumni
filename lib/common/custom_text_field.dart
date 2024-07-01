import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.onChange,
    this.labelText,
    this.hintText,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.height,
    this.width,
    this.color,
    this.maxLines,
    this.inputFormatters,
    this.minLines,
    this.radius,
  });

  final TextEditingController? controller;
  final void Function(String)? onChange;
  final String? labelText;
  final String? hintText;
  final Widget? label;

  // final ? prefix;
  // final ? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color ?? CupertinoColors.systemGrey5,
        borderRadius: BorderRadius.all(
          Radius.circular(radius ?? 3),
        ),
      ),
      height: height,
      width: width,
      alignment: height != null ? Alignment.center : null,
      child: TextFormField(
        minLines: minLines,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        keyboardType: keyboardType,
        controller: controller,
        cursorHeight: 25,
        onChanged: onChange,
        style: const TextStyle(
          fontSize: 12,
          letterSpacing: 1.5,
          color: Colors.black,
          fontWeight: FontWeight.w100,
          fontFamily: 'poppins',
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w100,
            fontFamily: 'poppins',
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          suffixIconColor: Colors.black,
          hintStyle: const TextStyle(fontFamily: 'poppins'),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
        ),
      ),
    );
  }
}
