import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/Auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        backgroundColor: const Color.fromARGB(255, 96, 171, 217),
      ),
      body: Column(
        children: [
          const Text(
            "We've send you email verification. Please open it to verify your account.",
          ),
          const Text(
            "If you haven't received a verification email yet, Press the button below",
          ),
          TextButton(
            onPressed: () async {
              await AuthService.Firebase().sendEmailVerification();
            },
            child: const Text('Send Email Verification'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.Firebase().logOut();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(registerRoutes, (route) => false);
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }
}
