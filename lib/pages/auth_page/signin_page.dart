import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_with_firebase/pages/auth_page/register_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_const.dart';
import '../../widgets/widget.dart';

class SignInPage extends StatelessWidget {
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
                          const AppTextField(
                            hintText: 'Phone, email or username',
                            inputType: TextInputType.text,
                          ),
                          const _PasswordField(),
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
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
                            style: AppConst.kBodyText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        )
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
          buttonName: 'Sign In',
          onTap: () {},
          bgColor: Colors.white,
          textColor: Colors.black87,
        ),
      ),
    );
  }
}

class _PasswordField extends StatefulWidget {
  const _PasswordField();

  @override
  __PasswordFieldState createState() => __PasswordFieldState();
}

class __PasswordFieldState extends State<_PasswordField> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return AppPasswordField(
      isPasswordVisible: isPasswordVisible,
      onTap: () {
        setState(() {
          isPasswordVisible = !isPasswordVisible;
        });
      },
    );
  }
}
