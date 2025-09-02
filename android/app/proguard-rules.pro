#######################################
# Razorpay (reflection based)
#######################################
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

#######################################
# Firebase
#######################################
-keep class com.google.firebase.** { *; }
-keepattributes *Annotation*
-dontwarn com.google.firebase.**

#######################################
# Flutter Local Notifications
#######################################
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-keep class com.dexterous.** { *; }
-dontwarn com.dexterous.**

#######################################
# Flutter generated plugins
#######################################
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.plugins.**

#######################################
# Core Flutter / Dart
#######################################
-keep class io.flutter.app.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

#######################################
# Kotlin (if you’re using coroutines / reflection)
#######################################
-keepclassmembers class kotlinx.coroutines.** { *; }
-dontwarn kotlinx.coroutines.**
