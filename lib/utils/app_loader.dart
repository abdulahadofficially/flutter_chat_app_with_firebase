import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoader {
  static Widget showLoading(
      {double size = 50, Color color = const Color(0xFF1A1A3F)}) {
    return Center(
      child: LoadingAnimationWidget.progressiveDots(
        color: color,
        size: size,
      ),
    );
  }
}
