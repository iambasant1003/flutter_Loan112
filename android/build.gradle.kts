buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        // Google Services plugin (latest stable)
        classpath("com.google.gms:google-services:4.4.2")

        // Firebase Crashlytics Gradle plugin (latest stable)
        classpath("com.google.firebase:firebase-crashlytics-gradle:3.0.2")
    }
}

val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)

    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
