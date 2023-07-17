import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_authentication/pages/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> signWithGoogle() async {
    // create an instance of the firebase auth and google sign
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // triger the auth flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // obtain the auth details from the req
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // create a new credentials
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // sign in the user with the credentials
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign'),
      ),
      body: Center(
        child: TextButton.icon(
            onPressed: () async {
              await signWithGoogle();
              if (mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              }
            },
            icon: const Icon(Icons.settings),
            label: const Text('Continue with google')),
      ),
    );
  }
}
