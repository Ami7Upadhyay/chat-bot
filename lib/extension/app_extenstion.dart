import 'package:flutter/material.dart';

extension ImageAssets on String {
  String get toSvg => 'images/$this.svg';
  String get toPng => 'images/$this.png';
}

extension VerticalPadding on num {
  Widget get vPad => SizedBox(height: this.toDouble());
}

extension HorizontalPadding on num {
  Widget get hPad => SizedBox(width: this.toDouble());
}
