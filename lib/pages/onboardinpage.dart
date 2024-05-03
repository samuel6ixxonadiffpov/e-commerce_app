//import 'package:agricapp/pages/home_page.dart';
import 'package:agricapp/pages/home_page.dart';
import 'package:agricapp/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 380),
                child: Image.asset('assets/onboarding.png'),
              ),
              const Spacer(),
              Text('Welcome to Agriplant',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "Get your agriculture products from the comfort of your home. You're just a few clicks away from your favorite products.",
                  textAlign: TextAlign.center,
                ),
              ),
              /**/
              FilledButton.tonalIcon(
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                  final UserCredential userCredential =
                      await AuthService().signInWithGoogle();
                  final User user = userCredential.user!;
                  final String userName = user.displayName ?? '';
                  // Get user's display name
                  final String profilePicUrl = user.photoURL ?? "";
                  // Get profile picture URL
                  final String email = user.email ?? "";

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        userName: userName,
                        email: email,
                        profilePicUrl: profilePicUrl,
                      ),
                    ),
                  );
                  // Assuming AuthService returns a user object
                  Navigator.pop(context); // Dismiss progress dialog
                  if (userCredential.user != null) {
                    // Successful sign-in, show message and navigate
                    final User user = userCredential.user!;
                    final String userName = user.displayName ?? '';
                    final String profilePicUrl = user.photoURL ?? '';
                    ; // Get profile picture URL
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Signed in successful! Welcome, $userName'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          userName: userName,
                          profilePicUrl: profilePicUrl,
                          email: email,
                        ),
                      ),
                    );
                  } else {
                    // Handle sign-in failure (optional)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sign in failed. Please try again.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                icon: const Icon(IconlyLight.login),
                label: const Text("Continue with Google"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
