import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_with_firebase/routes.dart';
import 'package:get/get.dart';
import '../../constants/app_const.dart';
import '../../widgets/widget.dart';
import '../auth_page/register_page.dart';
import '../auth_page/signin_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const Image(
                          image:
                              AssetImage('assets/images/team_illustration.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Enterprise team\ncollaboration.",
                      style: AppConst.kHeadline,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Text(
                        "Bring together your files, your tools, project and people.Including a new mobile and desktop application.",
                        style: AppConst.kBodyText,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Expanded(
                child: AppTextButton(
                  bgColor: Colors.white,
                  buttonName: 'Register',
                  onTap: () {
                    Get.toNamed(AppRoutes.register);
                  },
                  textColor: Colors.black87,
                ),
              ),
              Expanded(
                child: AppTextButton(
                  bgColor: Colors.transparent,
                  buttonName: 'Sign In',
                  onTap: () {
                    Get.toNamed(AppRoutes.signIn);
                  },
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
