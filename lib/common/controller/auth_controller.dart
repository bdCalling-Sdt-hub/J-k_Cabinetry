import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../app/modules/cart/controllers/cart_controller.dart';
import '../../app/modules/profile/controllers/profile_controller.dart';
import '../../app/routes/app_pages.dart';
import '../app_constant/app_constant.dart';
import '../prefs_helper/prefs_helpers.dart';

class AuthController extends GetxController {
  final CartController _cartController = Get.put(CartController());
  final ProfileController _profileController = Get.put(ProfileController());

  Future<void> logout() async {
    try {
      // Clear all stored data
      await PrefsHelper.remove(AppConstants.signInToken);
      await PrefsHelper.remove(AppConstants.userId);
      await PrefsHelper.remove('user_verification_status');

      // Clear cart
      await _cartController.clearCart();

      // Clear profile data
      _profileController.clearProfileData();

      // Reset GetX state
      Get.reset();

      // Navigate to login screen and remove all previous routes
      Get.offAllNamed(Routes.SIGN_IN);
    } catch (e) {
      print('Logout error: $e');
    }
  }

  Future<void> onLoginSuccess(String token, String userId) async {
    try {
      // Save new credentials
      await PrefsHelper.setString(AppConstants.signInToken, token);
      await PrefsHelper.setString(AppConstants.userId, userId);

      // Clear any existing profile data
      _profileController.clearProfileData();

      // Fetch fresh profile data
      await _profileController.fetchProfileData();

      // Navigate to home screen and remove all previous routes
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      print('Login success handling error: $e');
    }
  }
}