import 'package:flutter/material.dart';
import 'utils.dart';

class LoadingPro extends StatelessWidget {
  final double? size;
  final bool isLinear;
  final Color? valueColor, backgroundColor;
  LoadingPro(
      {this.size,
      this.isLinear = false,
      this.valueColor = Clr.colorPrimary,
      this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Center(
        child: isLinear
            ? LinearProgressIndicator(
                backgroundColor: backgroundColor,
                valueColor: new AlwaysStoppedAnimation<Color>(valueColor!),
              )
            : CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(valueColor!),
              ),
//      child: LinearProgressIndicator(),
      ),
    );
  }
}
