import 'package:flutter/material.dart';
import 'package:flutter_chat_app_with_firebase/constants/app_const.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/widget.dart';

class RegisterPage extends StatelessWidget {
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
                          const AppTextField(
                            hintText: 'Name',
                            inputType: TextInputType.name,
                          ),
                          const AppTextField(
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                          ),
                          const AppTextField(
                            hintText: 'Phone',
                            inputType: TextInputType.phone,
                          ),
                          _PasswordField(),
                        ],
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
        child: AppTextButton(
          buttonName: 'Register',
          onTap: () {},
          bgColor: Colors.white,
          textColor: Colors.black87,
        ),
      ),
    );
  }
}

class _PasswordField extends StatefulWidget {
  @override
  __PasswordFieldState createState() => __PasswordFieldState();
}

class __PasswordFieldState extends State<_PasswordField> {
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return AppPasswordField(
      isPasswordVisible: passwordVisibility,
      onTap: () {
        setState(() {
          passwordVisibility = !passwordVisibility;
        });
      },
    );
  }
}
