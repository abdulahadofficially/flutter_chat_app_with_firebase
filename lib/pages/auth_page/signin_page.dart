import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_with_firebase/controllers/auth_controllers.dart';
import 'package:flutter_chat_app_with_firebase/pages/auth_page/register_page.dart';
import 'package:flutter_chat_app_with_firebase/routes.dart';
import 'package:flutter_chat_app_with_firebase/utils/app_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/app_const.dart';
import '../../widgets/widget.dart';

class SignInPage extends GetView<AuthController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConst.kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            width: 24,
            color: Colors.white,
            'assets/images/back_arrow.svg',
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: controller.loginKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome back.",
                              style: AppConst.kHeadline,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "You've been missed!",
                              style: AppConst.kBodyText2,
                            ),
                            const SizedBox(height: 60),
                            AppTextField(
                              controller: controller.emailController,
                              hintText: 'Email',
                              inputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email cannot be empty';
                                } else if (!AppConst.emailRegExp
                                    .hasMatch(value)) {
                                  return 'Enter a valid email format (e.g. example@mail.com)';
                                }
                                return null;
                              },
                            ),
                            PasswordField(controller: controller),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: AppConst.kBodyText,
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.register),
                            child: Text(
                              'Register',
                              style: AppConst.kBodyText.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Obx(
                          () => AppTextButton(
                            isLoading: controller.isLoading.value,
                            buttonName: 'Sign In',
                            onTap: () async => await controller.login(),
                            bgColor: Colors.white,
                            textColor: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.controller});

  final AuthController controller;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return AppPasswordField(
      controller: widget.controller.passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email cannot be empty';
        } else if (!AppConst.passwordRegExp.hasMatch(value)) {
          return 'Password must be 8+ chars with uppercase, number & symbol.';
        }
        return null;
      },
      isPasswordVisible: isPasswordVisible,
      onTap: () {
        setState(() {
          isPasswordVisible = !isPasswordVisible;
        });
      },
    );
  }
}
