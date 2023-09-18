import 'package:decisive_technology_products/utils/txt.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../main.dart';
import '../s.dart';

// ignore: must_be_immutable
class TxtInput extends StatelessWidget {
  final String? prefixText, labelTxt;
  String? hintText;
  final Widget? prefixIcon, postFixIcon;
  Color? filledColor, borderColor, hintTextColor, textColor, labelColor;
  double? radius,
      marginHorizontal,
      paddingHorizontal,
      textSize,
      hintTextSize,
      labelSize;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  int? maxLines, maxLength;
  final bool hasBorder, isPassword, enabled, hasLabel;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final List<MaskTextInputFormatter>? inputFormatters;
  final TextAlign textAlign;

  TextCapitalization textCapitalization;

  TxtInput(
      {this.hintText,
      this.prefixText,
      this.labelTxt,
      this.prefixIcon,
      this.postFixIcon,
      this.hintTextColor,
      this.textColor,
      this.labelColor = Clr.colorPrimary,
      this.filledColor = Clr.colorTransparent,
      this.borderColor,
      this.radius = Siz.fieldRadius,
      this.textSize,
      this.hintTextSize,
      this.labelSize,
      this.marginHorizontal = 0.0,
      this.paddingHorizontal = Siz.standardPadding,
      this.controller,
      this.onChanged,
      this.onTap,
      this.maxLines,
      this.maxLength,
      this.hasBorder = false,
      this.isPassword = false,
      this.enabled = true,
      this.hasLabel = true,
      this.keyboardType,
      this.textInputAction,
      this.onEditingComplete,
      this.focusNode,
      this.inputFormatters,
      this.textAlign = TextAlign.start,
      this.textCapitalization = TextCapitalization.sentences});

  @override
  Widget build(BuildContext context) {
    if (borderColor == null) borderColor = Clr.colorPrimary;

    if (textColor == null) textColor = Colors.black;
    if (hintTextColor == null) hintTextColor = Clr.colorGreyBackground;

    if (this.isPassword) {
      this.maxLines = 1;
    }
    if (labelSize == null) {
      labelSize = textSize;
    }

    if (labelTxt != null) {
      if (hintText == null) {
        hintText = labelTxt;
      }
    }
    return old();
  }

  old() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (labelTxt != null)
          Container(
//            padding: EdgeInsets.symmetric(horizontal: Siz.standardPadding, vertical: ),
            child: Txt(
              labelTxt!,
              size: labelSize,
              textColor: labelColor,
            ),
          ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: deviceWidth,
            margin: EdgeInsets.symmetric(horizontal: marginHorizontal!),
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal!),
            decoration: S.sBoxDecorationNew(
                hasBorder: hasBorder,
                borderColor: borderColor!,
                radius: radius!,
                filledColor: filledColor!),
            child: IgnorePointer(
              ignoring: onTap == null ? false : true,
              child: TextField(
                maxLines: maxLines,
                maxLength: maxLength,
                controller: controller,
                inputFormatters: inputFormatters,
                textAlign: textAlign,
                textCapitalization: textCapitalization,
                style: TextStyle(fontSize: textSize, color: textColor),
                decoration: InputDecoration(
                    prefixText: prefixText,
                    prefixStyle: TextStyle(color: Clr.colorPrimary),
                    labelText: hasLabel ? hintText : null,
                    border: hasBorder ? InputBorder.none : null,
                    hintText: hintText,
                    hintStyle:
                        TextStyle(fontSize: textSize, color: hintTextColor),
                    suffixIcon: postFixIcon,
                    prefixIcon: prefixIcon,
                    counterText: '',
                    enabled: enabled),
                obscureText: isPassword,
                keyboardType: keyboardType,
                onChanged: onChanged,
                textInputAction: textInputAction,
                onEditingComplete: onEditingComplete,
                focusNode: focusNode,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
