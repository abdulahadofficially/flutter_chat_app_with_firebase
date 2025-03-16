import 'package:flutter_chat_app_with_firebase/bindings/auth_bindings.dart';
import 'package:flutter_chat_app_with_firebase/bindings/chat_bindings.dart';
import 'package:flutter_chat_app_with_firebase/pages/chat_page/chat_page.dart';
import 'package:flutter_chat_app_with_firebase/pages/chat_page/chat_user_page.dart';
import 'package:flutter_chat_app_with_firebase/pages/welocome_page/welcome_page.dart';
import 'package:get/get.dart';
import '../pages/auth_page/register_page.dart';
import 'pages/auth_page/signin_page.dart';

class AppRoutes {
  static const String signIn = '/sign-in';
  static const String register = '/register';
  static const String home = '/home';
  static const String welocomePage = '/welcome';
  static const String chatUserPage = '/chatUserPage';
  static const String chatPage = '/chatPage';

  static final routes = [
    GetPage(
      name: signIn,
      page: () => const SignInPage(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: register,
      page: () => const RegisterPage(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: welocomePage,
      page: () => const WelcomePage(),
    ),
    GetPage(
      name: chatUserPage,
      page: () => const ChatUserPage(),
      bindings: [ChatBindings(), AuthBindings()],
    ),
    GetPage(
      name: chatPage,
      page: () =>  ChatPage(),
      bindings: [ChatBindings()],
    ),
  ];
}
