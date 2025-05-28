# Stripe SDK - Fix for R8 missing classes error
-keep class com.stripe.android.** { *; }
-dontwarn com.stripe.android.**

# React Native Stripe SDK
-keep class com.reactnativestripesdk.** { *; }
-dontwarn com.reactnativestripesdk.**