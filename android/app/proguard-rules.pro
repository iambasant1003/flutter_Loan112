# Keep proguard annotation types referenced by libraries (eg. Razorpay)
-keep class proguard.annotation.** { *; }
-dontwarn proguard.annotation.**

# Keep classes referenced directly by reflection / analytics if needed (adjust if missing_rules.txt suggests other rules)
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**
