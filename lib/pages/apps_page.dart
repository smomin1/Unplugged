import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

class AppsPage extends StatefulWidget {
  const AppsPage({super.key});

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Open Social Media Apps'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await LaunchApp.openApp(
                    androidPackageName: 'com.instagram.android', // Instagram package
                    iosUrlScheme: 'instagram://', // Instagram iOS URL scheme
                    appStoreLink: 'https://apps.apple.com/us/app/instagram/id389801252',
                  );
                },
                child: Text('Open Instagram'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await LaunchApp.openApp(
                    androidPackageName: 'com.facebook.katana', // Facebook package
                    iosUrlScheme: 'fb://', // Facebook iOS URL scheme
                    appStoreLink: 'https://apps.apple.com/us/app/facebook/id284882215',
                  );
                },
                child: Text('Open Facebook'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await LaunchApp.openApp(
                    androidPackageName: 'com.google.android.youtube', // YouTube package
                    iosUrlScheme: 'youtube://', // YouTube iOS URL scheme
                    appStoreLink: 'https://apps.apple.com/us/app/youtube/id544007664',
                  );
                },
                child: Text('Open YouTube'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await LaunchApp.openApp(
                    androidPackageName: 'com.snapchat.android', // Snapchat package
                    iosUrlScheme: 'snapchat://', // Snapchat iOS URL scheme
                    appStoreLink: 'https://apps.apple.com/us/app/snapchat/id447188370',
                  );
                },
                child: Text('Open Snapchat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
