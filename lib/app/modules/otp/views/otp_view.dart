import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/otp/controllers/resend_otp_controller.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_string/app_string.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/otp_controller.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  OtpController otpController = Get.put(OtpController());
  ResendOtpController resendOtpController = Get.put(ResendOtpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _start = 59; // 3 min
  Timer _timer = Timer(const Duration(seconds: 1), () {});
  final String email = Get.arguments['email'] ?? '';

  startTimer() {
    print("Start $_start");
    print("Start Time$_timer");
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  String get timerText {
    int minutes = _start ~/ 60;

    /// ~/ eta vag kora {When (_start 179 ~/ 60=2.98 ),(_start 119 ~/ 60 = 1.98 ),(_start 59 ~/ 60 = 0.98 ) }
    int seconds = _start % 60;

    /// Vag sesh, The remainder is 150−120=30, 30 is reminder, if _start is 119 then second will set to 59 cause reminder is 59 ({60*2=120} then 60*1=60 ,if 119 then 119-60=59)
    /// When _start = 59 is divided by 60, the quotient is 0 (since 59 is less than 60), and the remainder is 59. {eta hocce vag sesh , jeta dea multiply kora jabe na obosisto number ty reminder hobe }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool isResetPassword = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    if (Get.arguments != null && Get.arguments['isResetPass'] != null) {
      resetPassConfirmation();
    }
  }

  resetPassConfirmation() {
    bool resetPass = Get.arguments['isResetPass'] as bool;
    if (resetPass == true) {
      isResetPassword = resetPass;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarTitle(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 55.h),
                buildOtpSupportText(email: email),
                SizedBox(height: 30.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PinCodeTextField(
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.number,
                      controller: otpController.otpCtrl,
                      autoDisposeControllers: false,
                      enablePinAutofill: false,
                      appContext: context,
                      autoFocus: true,
                      textStyle: const TextStyle(),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.circle,
                        borderRadius: BorderRadius.circular(4).r,
                        fieldHeight: 58.h,
                        fieldWidth: 50.w,
                        activeFillColor: AppColors.gray.withOpacity(0.7),
                        selectedFillColor: AppColors.white,
                        inactiveFillColor: AppColors.white,
                        borderWidth: 0.5,
                        errorBorderColor: Colors.red,
                        activeBorderWidth: 0.5,
                        selectedColor: AppColors.primaryColor,
                        inactiveColor: AppColors.black,
                        activeColor: AppColors.primaryColor,
                      ),
                      length: 6,
                      enableActiveFill: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your pin code';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    Text(timerText,
                        style: AppStyles.h4(color: AppColors.primaryColor)),

                    SizedBox(height: 20.h),

                    ///======Confirm Button======
                    Obx(
                          () {
                        return CustomButton(
                          loading: otpController.isLoading.value,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              otpController.sendOtp();
                            }
                          },
                          text: AppString.confirmText,
                        );
                      },
                    ),

                    SizedBox(height: 20.h),

                    /// Resent Button
                    timerText == "00:00"
                        ? InkWell(
                      onTap: () {
                        resendOtpController.sendMail(false);
                        _start = 150;
                        startTimer();
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Didn’t receive code? ",
                            style: AppStyles.customSize(
                              size: 14,
                              family: "Schuyler",
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                          Text(
                            "Resend it",
                            style: AppStyles.customSize(
                              size: 15,
                              family: "Schuyler",
                              fontWeight: FontWeight.w500,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    )
                        : const SizedBox(),
                  ],
                ),
                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RichText buildOtpSupportText({String? email}) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "We have sent a verification email to ",
        style: AppStyles.h4(color: AppColors.gray), // Use default text style
        children: [
          TextSpan(
            text: email ?? '', // Highlighted email
            style: const TextStyle(
              color: AppColors.gray, // Change color for the email
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text:
            ". If you don't see the email in your inbox, check your spam folder. Email codes can take up to 1-2 minutes to arrive :",
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    otpController.otpCtrl.clear();
    super.dispose();
  }


}
