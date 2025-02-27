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
      body: _buildUI(),
      floatingActionButton: _authButton(),
    );
  }

  Widget _authButton() {
    return FloatingActionButton(
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
                print("$didAuthenticate");

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
      child: Icon(
        _isauthenticated ? Icons.lock : Icons.lock_open,
      ),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "App Lock",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (!_isauthenticated)
            const Text(
              "*******",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
