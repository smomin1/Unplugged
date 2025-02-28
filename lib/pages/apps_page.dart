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
        body: Center( // Centering the whole body content
          child: Padding( // Optional padding to provide some spacing from the edges
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 buttons in each row
                crossAxisSpacing: 20, // Space between columns
                mainAxisSpacing: 20, // Space between rows
              ),
              itemCount: 4, // Number of buttons
              shrinkWrap: true, // Ensures the grid view does not take up more space than needed
              physics: NeverScrollableScrollPhysics(), // Disables scrolling
              itemBuilder: (context, index) {
                // List of apps with their respective logo paths
                List<Map<String, dynamic>> apps = [
                  {
                    'name': 'Open Instagram',
                    'package': 'com.instagram.android',
                    'urlScheme': 'instagram://',
                    'appStoreLink': 'https://apps.apple.com/us/app/instagram/id389801252',
                    'logo': 'assets/images/instagram.png', // Instagram logo path
                  },
                  {
                    'name': 'Open Facebook',
                    'package': 'com.facebook.katana',
                    'urlScheme': 'fb://',
                    'appStoreLink': 'https://apps.apple.com/us/app/facebook/id284882215',
                    'logo': 'assets/images/facebook.png', // Facebook logo path
                  },
                  {
                    'name': 'Open YouTube',
                    'package': 'com.google.android.youtube',
                    'urlScheme': 'youtube://',
                    'appStoreLink': 'https://apps.apple.com/us/app/youtube/id544007664',
                    'logo': 'assets/images/youtube.png', // YouTube logo path
                  },
                  {
                    'name': 'Open Snapchat',
                    'package': 'com.snapchat.android',
                    'urlScheme': 'snapchat://',
                    'appStoreLink': 'https://apps.apple.com/us/app/snapchat/id447188370',
                    'logo': 'assets/images/snapchat.png', // Snapchat logo path
                  },
                ];

                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 150), // Make buttons square
                    padding: EdgeInsets.all(16), // Optional padding for better visuals
                  ),
                  onPressed: () async {
                    await LaunchApp.openApp(
                      androidPackageName: apps[index]['package'],
                      iosUrlScheme: apps[index]['urlScheme'],
                      appStoreLink: apps[index]['appStoreLink'],
                    );
                  },
                  child: Image.asset(
                    apps[index]['logo'],
                    width: 100,  // Set width of the logo
                    height: 100, // Set height of the logo
                    fit: BoxFit.contain, // Ensure the image maintains its aspect ratio
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
