# FinnEasy!

FinnEasy is a Stock Trading Gaming Application open for General Users.
The following documentation will help you understand the configuration needed in system before startup.

App uses Flutter Framework. To setup Dart and Flutter go to https://flutter.dev/docs/get-started/install to get started.

## Learning
- We use Dart and Flutter, there are many courses available, along with docs.
- For state-management learn about MobX.
- Check how REST APIs are called using http client.

## Setting up
- Make sure to run ``` flutter doctor ``` once, you have installed Flutter.
- Ensure that all licenses are checked in Android Studio and proper packages are installed.
- Setup any IDE of your choice we usually use VSCode as it got smooth and relaxing UI, along with powerful plugin integrations.

## Steps to Run the App:
- To Download Dependencies:  ``` flutter pub get ```.
- To Generate Stores Code: ``` flutter pub run build_runner build --delete-conflicting-outputs ```.
- To Run Code: Connect a physical device with USB Debugging on or launch an emulator. Now run ```flutter run```.

That is it! You should be able to build and run the app.

## Building APK
- Release APK: ``` flutter build apk --split-per-abi ``` 

Hope you enjoy and learn in the project.

### This project is under SGSITS
