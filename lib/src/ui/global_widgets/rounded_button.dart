// ignore_for_file: unnecessary_this

import 'package:delivery_food/src/utils/colors.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  //variables que pasaremos por paremtro
  final VoidCallback onPressed;
  final String label;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final bool fullWidth;
  final EdgeInsets padding;
  final double? fontSize;
  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.textColor = Colors.white,
    this.backgroundColor = primarycolor,
    this.borderColor = primarycolor,
    this.fullWidth = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 9),
    this.fontSize, //valor que sera por defecto
  }) : //assert(label != null), //assert pa hacer validaciones, q null no sea nulo y fontzise sea mayor a 0
        // assert(fontSize > 0), //se usa mas assert en propiedades con valor no asignado
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Container(
        width: fullWidth ? double.infinity : null, //old null
        padding: this.padding,
        decoration: BoxDecoration(
          color: this.backgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1.4, color: this.borderColor),
        ),
        child: Text(
          this.label,
          textAlign: TextAlign.center,
          style: FontStyles.normal.copyWith(
            fontWeight: FontWeight.w700,
            color: this.textColor,
            fontSize: this.fontSize,
          ),
        ),
      ),
      minSize: 30,
      padding: EdgeInsets.zero,
      onPressed: this.onPressed,
    );
  }
}
