import 'package:decisive_technology_products/utils/txt.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../s.dart';
import '../utils/utils.dart';
import 'package:get/utils.dart';

// ignore: must_be_immutable
class Btn extends StatelessWidget {
  final String? value;
  Color? backgroundColor, textColor, borderColor, prefixColor;
  Color? postfixColor;
  final VoidCallback? onPressed;
  final double? width,
      borderRadius,
      textSize,
      marginVertical,
      marginHorizontal,
      paddingHorizontal,
      paddingVertical,
      prefixSize,
      postfixSize;
  double? height;
  final TextAlign? textAlign;
  final dynamic prefix, postFix;
  final bool isIcon, textBold;

  Btn(
    this.value, {
    this.onPressed,
    this.backgroundColor = Clr.colorGreyButton,
    this.textColor = Colors.black,
    this.textSize = Siz.h4,
    this.textAlign,
    this.borderColor,
    this.prefix,
    this.postFix,
    this.prefixColor,
    this.paddingHorizontal = 20,
    this.marginVertical = 0,
    this.marginHorizontal = 0,
    this.paddingVertical = 0,
    this.height,
    this.width,
    this.borderRadius = Siz.fieldRadius,
    this.prefixSize,
    this.postfixSize,
    this.isIcon = false,
    this.textBold = false,
  });
  @override
  Widget build(BuildContext context) {
    if (borderColor == null) {
      borderColor = Clr.colorGreyButton;
    }
    if (textColor == null) {
      this.textColor = Clr.colorPrimary;
    }

    if (height == null) {
      height = setHeight(0.08);
    }
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: 1.seconds,
        height: height,
        width: width,
        padding:
            EdgeInsets.symmetric(horizontal: paddingHorizontal!, vertical: 5),
        margin: EdgeInsets.symmetric(
            horizontal: marginHorizontal!, vertical: marginVertical!),
        decoration: S.sBoxDecorationWithoutShadow(
            borderColor: borderColor!,
            radius: borderRadius!,
            filledColor: onPressed == null
                ? Clr.colorGreyButton
                : backgroundColor ?? Colors.grey),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (prefix != null)
                isIcon
                    ? Icon(prefix, color: prefixColor, size: prefixSize)
                    : Image.asset(
                        prefix,
                        width: prefixSize,
                        color: prefixColor,
                        fit: BoxFit.cover,
                      ),
              FittedBox(
                  child: Txt(
                value ?? "",
                textColor: textColor!,
                size: textSize!,
                textAlign: textAlign ?? TextAlign.center,
                hasBold: textBold,
              )),
              if (postFix != null)
                isIcon
                    ? Icon(postFix, color: postfixColor, size: postfixSize)
                    : Image.asset(postFix,
                        width: postfixSize,
                        height: postfixSize,
                        color: prefixColor,
                        fit: BoxFit.cover),
            ],
          ),
        ),
      ),
    );
  }
}
