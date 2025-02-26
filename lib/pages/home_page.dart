import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalAuthentication _auth = LocalAuthentication();

  bool _isauthenticated = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
      floatingActionButton: _authButton(),
    );
  }

  Widget _authButton(){
    return FloatingActionButton(
      onPressed: () async {
      if (!_isauthenticated) {
        final bool canAuthenticateBiometerics = await _auth.canCheckBiometrics;
        if (canAuthenticateBiometerics) {
          try {
            final bool didAuthenticate = await _auth.authenticate(
                localizedReason: "Please authenticate to access the apps",
                options: const AuthenticationOptions(
                  biometricOnly: false,
              )
            
            );
            
            setState(() {
              _isauthenticated = didAuthenticate;
              print("$didAuthenticate");
            });
          } catch (e) {
            print(e);
          }
        }
      }else{
        setState(() {
          _isauthenticated = false;
        });
      }

      // setState(() {
      //   _isauthenticated = !_isauthenticated;
      // });
    },
      child: Icon(_isauthenticated ? Icons.lock : Icons.lock_open, ),
    );
  
  }

  Widget _buildUI(){
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
          )
        ),

        if (_isauthenticated) const Text(
            "Instagram Link",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )
        ),
          if (!_isauthenticated) const Text(
              "*******",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )
          )
      ],
      ),
    );

  }
}
