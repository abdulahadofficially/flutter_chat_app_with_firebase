import 'package:flutter/material.dart';
import 'package:flutter_chat_app_with_firebase/constants/app_const.dart';
import 'package:flutter_chat_app_with_firebase/controllers/auth_controllers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../widgets/widget.dart';

class RegisterPage extends GetView<AuthController> {
  const RegisterPage({super.key});

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
            'assets/images/back_arrow.svg',
            width: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Flexible(
                      child: Form(
                        key: controller.signupKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Register",
                              style: AppConst.kHeadline,
                            ),
                            const Text(
                              "Create new account to get started.",
                              style: AppConst.kBodyText2,
                            ),
                            const SizedBox(height: 50),
                            AppTextField(
                              controller: controller.nameController,
                              hintText: 'Name',
                              inputType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Name cannot be empty';
                                } else if (!AppConst.usernameRegExp
                                    .hasMatch(value)) {
                                  return 'Enter a valid Name format (e.g. abdulahad)';
                                }
                                return null;
                              },
                            ),
                            AppTextField(
                              controller: controller.emailController,
                              hintText: 'Email',
                              inputType: TextInputType.emailAddress,
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
                            AppTextField(
                              controller: controller.phoneController,
                              hintText: 'Phone',
                              inputType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone cannot be empty';
                                } else if (!AppConst.phoneRegExp
                                    .hasMatch(value)) {
                                  return 'Enter a valid phone format (e.g. +92311********)';
                                }
                                return null;
                              },
                            ),
                            PasswordField(controller: controller),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: AppConst.kBodyText,
                        ),
                        Text(
                          "Sign In",
                          style: AppConst.kBodyText.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Obx(
          () =>  AppTextButton(
            isLoading: controller.isLoading.value,
            buttonName: 'Register',
            onTap: () => controller.register(),
            bgColor: Colors.white,
            textColor: Colors.black87,
          ),
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
