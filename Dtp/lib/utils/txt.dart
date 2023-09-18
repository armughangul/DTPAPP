import 'package:flutter/material.dart';
import 'utils.dart';

// ignore: must_be_immutable
class Txt extends StatelessWidget {
  final String userName;
  final double? size,
      borderRadius,
      marginHorizontal,
      marginVertical,
      paddingHorizontal,
      paddingVertical,
      widthContainer,
      heightContainer,
      paddingAll,
      marginAll,
      lineSpace;
  final bool hasBorder, hasBold, checkOverflow, hasUnderline;
  Color borderColor, backgroundColor;
  Color? textColor;
  final TextAlign? textAlign;
  final int? maxLine;
  final GestureTapCallback? onTap;

  Txt(this.userName,
      {this.size = 14.0,
      this.borderRadius = 5.0,
      this.hasBorder = false,
      this.borderColor = Clr.colorPrimary,
      this.textColor,
      this.backgroundColor = Clr.colorTransparent,
      this.marginHorizontal = 0.0,
      this.marginVertical = 0.0,
      this.paddingHorizontal = 0.0,
      this.paddingVertical = 0.0,
      this.hasBold = false,
      this.checkOverflow = false,
      this.widthContainer,
      this.heightContainer,
      this.paddingAll,
      this.marginAll,
      this.textAlign,
      this.hasUnderline = false,
      this.maxLine,
      this.onTap,
      this.lineSpace});

  @override
  Widget build(BuildContext context) {
    return _text();
  }

  Widget _text() {
    if (textColor == null) {
      textColor = Colors.black;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: marginAll == null
              ? EdgeInsets.symmetric(
                  horizontal: marginHorizontal!, vertical: marginVertical!)
              : EdgeInsets.all(marginAll!),
          padding: paddingAll == null
              ? EdgeInsets.symmetric(
                  horizontal: paddingHorizontal!, vertical: paddingVertical!)
              : EdgeInsets.all(paddingAll!),
          width: widthContainer,
          height: heightContainer,
          decoration: hasBorder
              ? BoxDecoration(
                  border: Border.all(color: borderColor),
                  color: backgroundColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius!)),
                )
              : null,
          child: Text(
            userName ?? Str.NA,
            overflow: checkOverflow ? TextOverflow.ellipsis : null,
            textAlign: textAlign,
            style: TextStyle(
                color: textColor,
                fontSize: size,
                fontWeight: hasBold ? FontWeight.bold : FontWeight.normal,
                decoration: hasUnderline
                    ? TextDecoration.underline
                    : TextDecoration.none,
                height: lineSpace),
            maxLines: maxLine,
          )),
    );
  }
}
