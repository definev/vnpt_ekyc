# vnpt_ekyc

A common plugin for using VNPT_EKYC SDK in Flutter.

## Getting Started

Due to limitations of AGP, you need to import both `aar` file in plugin and app.

### App setup

1. Add the following to your `android/build.gradle` file:

```gradle
allprojects {
    repositories {
        google()
        jcenter()
        flatDir {
            dirs "libs"
        }
    }
}
```

Add `ekyc_sdk.aar` to `android/app/libs` folder.

2. Add the following to your `android/app/build.gradle` file:

```gradle
dependencies {
    implementation fileTree(dir: "libs", include: ["*.jar"])
}
```

You are ready to go.