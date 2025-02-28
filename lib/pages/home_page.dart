import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:unplugged/pages/loading_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalAuthentication _auth = LocalAuthentication();

  bool _isauthenticated = false;

  void _navigateToLoadingPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoadingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,  // Set background color to black
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/lock.png',  // Display lock image
            width: 200,  // Increased size of lock image
            height: 200, // Increased size of lock image
          ),
          const SizedBox(height: 40), // Space between lock and button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Set button background to green
              shadowColor: Colors.grey,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Add padding to button
            ),
            onPressed: () async {
              if (!_isauthenticated) {
                final bool canAuthenticateBiometrics = await _auth.canCheckBiometrics;
                if (canAuthenticateBiometrics) {
                  try {
                    final bool didAuthenticate = await _auth.authenticate(
                      localizedReason: "Please authenticate to access the apps",
                      options: const AuthenticationOptions(
                        biometricOnly: false,
                      ),
                    );

                    setState(() {
                      _isauthenticated = didAuthenticate;

                      // Navigate to LoadingPage if authentication is successful
                      if (_isauthenticated) {
                        _navigateToLoadingPage();
                      }
                    });
                  } catch (e) {
                    print(e);
                  }
                }
              } else {
                setState(() {
                  _isauthenticated = false;
                });
              }
            },
            child: const Text(
              'Unlock!',  // Text on the button
              style: TextStyle(
                fontSize: 18,        // Text size for button
                fontWeight: FontWeight.bold,  // Make text bold
                color: Colors.black, // Set text color to black
              ),
            ),
          ),
        ],
      ),
    );
  }
}
