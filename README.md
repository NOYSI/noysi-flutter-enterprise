# Noysi Flutter Enterprise

## Getting Started

This project is a white-label version of Noysi. You can customize icons, text and some behaviors related to share, links, push notifications and of course, the visibility of your new corporate app in Google Play and Apple Store.

A few resources to get you started:

As a flutter project you will find the main dart code under lib folder, an android folder, an iOS folder and the pubspec.yaml file which control the dependencies.

Before compile or build the app you must set some custom configurations in order to make the app compilable.
- On iOS create your own app group in order to join ShareExt, BroadcastExtension and Runner in the same group. Read the documentation of the libs [receive_sharing_intent](https://pub.dev/packages/receive_sharing_intent), [uni_links](https://pub.dev/packages/uni_links) and [jitsi_meet_wrapper](https://pub.dev/packages/jitsi_meet_wrapper) where you will find all the documentation you need to configure these features in Noysi. Whenever you need to set app group it's written as "YOUR-APP-GROUP" in the app code, you can use it as search criteria.
- For Firebase cloud message and other google cloud services to work you need to download your google-services.json and Google-Services.plist for Android and iOS and paste them on each folder. Please read Firebase documentation. GCM reverse domain is also necessary to Share Media with iOS, use "YOUR-GOOGLE-SERVICE-REVERSE-DOMAIN" as search criteria in the Info.plist file.
- You can configure your own internal link domain for internal apps communication, for example using your app bundle name: com.example so you can call your app with com.example://<url body>. Use "YOUR-APP-LINK" as search criteria.
- Configure your keystore to upload builds to Google Play. Write your keystore parameters in key.properties into the android folder.

Remember to execute pub get and pod install (iOS) commands to download dependencies and generate Pods and pubspec files.