import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/cabinetary_spec/cabinetary_spec.dart';
import 'package:jk_cabinet/app/modules/message/views/message_view.dart';
import 'package:jk_cabinet/app/modules/message_inbox/views/message_inbox_view.dart';
import 'package:jk_cabinet/app/modules/our_quality/commitment_to_quality.dart';
import 'package:jk_cabinet/app/modules/our_quality/craftsmanship.dart';
import 'package:jk_cabinet/app/modules/our_quality/maintenance_and_care.dart';
import 'package:jk_cabinet/app/modules/our_quality/standard_features.dart';
import 'package:jk_cabinet/app/modules/our_quality/sustainability.dart';
import 'package:jk_cabinet/app/modules/settings/bindings/about_us_binding.dart';
import 'package:jk_cabinet/app/modules/settings/bindings/privacy_binding.dart';
import 'package:jk_cabinet/app/modules/settings/bindings/settings_binding.dart';
import 'package:jk_cabinet/app/modules/settings/bindings/support_binding.dart';
import 'package:jk_cabinet/app/modules/settings/bindings/terms_binding.dart';
import 'package:jk_cabinet/app/modules/settings/views/about_screen.dart';
import 'package:jk_cabinet/app/modules/settings/views/privacy_police.dart';
import 'package:jk_cabinet/app/modules/settings/views/settings_view.dart';
import 'package:jk_cabinet/app/modules/settings/views/support_screen.dart';
import 'package:jk_cabinet/app/modules/settings/views/terms_screen.dart';

import '../modules/cabinet_detail/bindings/cabinet_detail_binding.dart';
import '../modules/cabinet_detail/views/cabinet_detail_view.dart';
import '../modules/cabinet_parts/bindings/cabinet_parts_binding.dart';
import '../modules/cabinet_parts/views/cabinet_parts_view.dart';
import '../modules/cabinet_parts_recentviewed_details/bindings/cabinet_parts_recentviewed_details_binding.dart';
import '../modules/cabinet_parts_recentviewed_details/views/cabinet_parts_recentviewed_details_view.dart';
import '../modules/cabinetry/bindings/cabinetry_binding.dart';
import '../modules/cabinetry/views/cabinetry_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/cart/views/checkout_view.dart';
import '../modules/cash_payment_process/bindings/cash_payment_process_binding.dart';
import '../modules/cash_payment_process/views/cash_payment_process_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/invoice/bindings/invoice_binding.dart';
import '../modules/invoice/views/invoice_view.dart';
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
        transition: Transition.cupertino),
    GetPage(
        name: _Paths.SIGN_IN,
        page: () => const SignInView(),
        binding: SignInBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: _Paths.SIGN_UP,
        page: () => const SignUpView(),
        binding: SignUpBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: _Paths.OTP,
        page: () => const OtpView(),
        binding: OtpBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: _Paths.FORGOT_PASSWORD,
        page: () => const ForgotPasswordView(),
        binding: ForgotPasswordBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: _Paths.CHANGE_PASSWORD,
        page: () => const ChangePasswordView(),
        binding: ChangePasswordBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: _Paths.PROFILE,
        page: () => ProfileView(),
        binding: ProfileBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: _Paths.PROFILE_UPDATE,
        page: () => ProfileUpdateView(),
        binding: ProfileUpdateBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: _Paths.CABINETRY,
        page: () => const CabinetryView(),
        binding: CabinetryBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: _Paths.CART,
        page: () => CartView(),
        binding: CartBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: _Paths.CABINET_DETAIL,
        page: () => const CabinetDetailView(),
        binding: CabinetDetailBinding(),
        transition: Transition.cupertino),
    GetPage(
        name: _Paths.CABINET_PARTS,
        page: () => const CabinetPartsView(),
        binding: CabinetPartsBinding(),
        transition: Transition.cupertino),
    GetPage(
      name: _Paths.CABINET_PARTS_RECENTVIEWED_DETAILS,
      page: () => const CabinetPartsRecentViewedDetailsView(),
      binding: CabinetPartsRecentviewedDetailsBinding(),
    ),
    GetPage(
        name: _Paths.CHECKOUT,
        page: () => CheckoutView(),
        binding: CartBinding(),
        transition: Transition.cupertino),
    GetPage(
      name: _Paths.CASH_PAYMENT_PROCESS,
      page: () => const CashPaymentProcessView(),
      binding: CashPaymentProcessBinding(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.INVOICE,
      page: () =>  InvoiceView(),
      binding: InvoiceBinding(),
        transition: Transition.cupertino
    ),

    GetPage(
      name: _Paths.COMMITMENTTOQULATITY,
      page: () =>  CommitmentToQuality(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.CRAFTSMANSHIP,
      page: () =>  Craftsmanship(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.MAINTENANCEANDCARE,
      page: () =>  MaintenanceAndCare(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.STANDARDFEATURES,
      page: () =>  StandardFeatures(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.SUSTAINABILITY,
      page: () =>  Sustainability(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.CABINETRYSPEC,
      page: () =>  CabinetrySpec(),
        transition: Transition.cupertino
    ),

    GetPage(
      name: _Paths.MESSAGE,
      page: () =>  MessageView(),
        transition: Transition.cupertino
    ),
    GetPage(
      name: _Paths.MESSAGE_INBOX,
      page: () =>  MessageInboxView(),
        transition: Transition.cupertino
    ),

    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutScreen(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: _Paths.PRIVAACY_POLICY,
      page: () => const PrivacyPoliceScreen(),
      binding: PrivacyBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT,
      page: () => const SupportScreen(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_CONDITION,
      page: () => const TermsAndConditionsScreen(),
      binding: TermsBinding(),
    ),
  ];
}
