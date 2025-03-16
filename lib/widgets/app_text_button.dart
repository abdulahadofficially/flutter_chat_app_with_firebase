import 'package:flutter/material.dart';
import 'package:flutter_chat_app_with_firebase/utils/app_loader.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constants/app_const.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.buttonName,
    required this.onTap,
    required this.bgColor,
    required this.textColor,
    this.isLoading = false,
  });
  final String buttonName;
  final void Function()? onTap;
  final Color bgColor;
  final Color textColor;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextButton(
        style: const ButtonStyle(
          overlayColor: WidgetStatePropertyAll(
            Colors.black12,
          ),
        ),
        onPressed: onTap,
        child: isLoading == true
            ? AppLoader.showLoading()
            : Text(
                buttonName,
                style: AppConst.kButtonText.copyWith(color: textColor),
              ),
      ),
    );
  }
}
