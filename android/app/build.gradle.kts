plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter Gradle plugin must come after Android/Kotlin plugins
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
}

android {
    namespace = "com.example.loan112_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11

        // ✅ Kotlin DSL syntax
        isCoreLibraryDesugaringEnabled = true
    }


    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.loan112_app"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += "default"

    productFlavors {
        create("dev") {
            dimension = "default"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
        }
        create("prod") {
            dimension = "default"
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            // Uncomment if using Crashlytics:
            // isMinifyEnabled = false
            // isShrinkResources = false
            // proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ✅ Add this line for desugaring support
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
