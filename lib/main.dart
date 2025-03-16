import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'routes.dart';
import 'theme/app_theme.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat App with Firebase',
      theme: appTheme(context),
      getPages: AppRoutes.routes,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: LoadingAnimationWidget.progressiveDots(
                  color: const Color(0xFF1A1A3F),
                  size: 50,
                ),
              ),
            );
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (snapshot.hasData) {
              Get.offAllNamed(AppRoutes.chatUserPage);
            } else {
              Get.offAllNamed(AppRoutes.welocomePage);
            }
          });

          return const SizedBox();
        },
      ),
    );
  }
}
