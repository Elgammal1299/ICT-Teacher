import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")

    // The Flutter Gradle Plugin must be applied after
    // the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(
        FileInputStream(keystorePropertiesFile)
    )
}

android {
    namespace = "com.ictgate2.app"

    compileSdk = flutter.compileSdkVersion

    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.ictgate2.app"

        // flutter_js requires Android 21+
        minSdk = flutter.minSdkVersion

        targetSdk = flutter.targetSdkVersion

        versionCode = 5
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias =
                keystoreProperties["keyAlias"] as String?

            keyPassword =
                keystoreProperties["keyPassword"] as String?

            storeFile =
                keystoreProperties["storeFile"]?.let {
                    file(it as String)
                }

            storePassword =
                keystoreProperties["storePassword"] as String?
        }
    }

    buildTypes {
        release {
            signingConfig =
                signingConfigs.getByName("release")
        }
    }
}

/*
 * JavaScriptCore Runtime
 *
 * نستخدمه مع flutter_js بدل QuickJS
 * لتجنب خطأ:
 *
 * libfastdev_quickjs_runtime.so not found
 */
dependencies {
    implementation(
        "com.github.fast-development.android-js-runtimes:fastdev-jsruntimes-jsc:0.3.4"
    )
}

flutter {
    source = "../.."
}
