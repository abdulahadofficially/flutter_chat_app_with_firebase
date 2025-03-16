import 'package:flutter/material.dart';
import 'package:flutter_chat_app_with_firebase/helpers/firebase_helper.dart';
import 'package:flutter_chat_app_with_firebase/models/user_model.dart';
import 'package:flutter_chat_app_with_firebase/routes.dart';
import 'package:flutter_chat_app_with_firebase/services/auth_service.dart';
import 'package:flutter_chat_app_with_firebase/services/user_service.dart';
import 'package:flutter_chat_app_with_firebase/utils/app_toast.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthServices _authServices = AuthServices();
  final UserService _userService = UserService();
  final loginKey = GlobalKey<FormState>();
  final signupKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;
    try {
      if (!(loginKey.currentState?.validate() ?? false)) return;
      final user = await _authServices.login(
          emailController.text, passwordController.text);
      if (user.user != null) {
        Get.offAllNamed(AppRoutes.chatUserPage);
      }
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    isLoading.value = true;
    try {
      if (!(signupKey.currentState?.validate() ?? false)) return;
      final user = await _authServices.register(
          emailController.text, passwordController.text);
      if (user.user != null) {
        final userModel = UserModel(
            id: user.user!.uid,
            userName: nameController.text,
            email: emailController.text,
            phoneNumber: phoneController.text);
        _userService
            .saveUser(userModel)
            .then((value) => Get.offAllNamed(AppRoutes.signIn));
      }
    } catch (e) {
      isLoading.value = false;
      AppToast.showErrorToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logoutUser() async {
    try {
      isLoading.value = true;
      _authServices.logout().then((value) {
        Get.offAndToNamed(AppRoutes.welocomePage);
      });
    } catch (e) {
      isLoading.value = false;
      AppToast.showSuccessToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
