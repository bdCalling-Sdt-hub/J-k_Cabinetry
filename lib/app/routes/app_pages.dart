import 'package:get/get.dart';

import '../modules/cabinet_detail/bindings/cabinet_detail_binding.dart';
import '../modules/cabinet_detail/views/cabinet_detail_view.dart';
import '../modules/cabinet_parts/bindings/cabinet_parts_binding.dart';
import '../modules/cabinet_parts/views/cabinet_parts_view.dart';
import '../modules/cabinetry/bindings/cabinetry_binding.dart';
import '../modules/cabinetry/views/cabinetry_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile_update/bindings/profile_update_binding.dart';
import '../modules/profile_update/views/profile_update_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGN_IN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.PROFILE_UPDATE,
      page: () => ProfileUpdateView(),
      binding: ProfileUpdateBinding(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.CABINETRY,
      page: () => const CabinetryView(),
      binding: CabinetryBinding(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.CABINET_DETAIL,
      page: () => const CabinetDetailView(),
      binding: CabinetDetailBinding(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.CABINET_PARTS,
      page: () =>  CabinetPartsView(),
      binding: CabinetPartsBinding(),
        transition: Transition.cupertino
    ),
  ];
}
