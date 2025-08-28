import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/Auth/auth_exceptions.dart';
import 'package:mynotes/services/Auth/auth_service.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color.fromARGB(255, 96, 171, 217),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.Firebase().logIn(
                  email: email,
                  password: password,
                );
                final user = AuthService.Firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  // user email is verified
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(notesRoutes, (route) => false);
                } else {
                  //user email is NOT verified
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false);
                }
              } on InvalidCredentialsAuthException {
                await showErrorDialog(
                  context,
                  'Invalid email or password. Please try again.',
                );
              } on GenericAuthException {
                await showErrorDialog(context, 'Authentication Error');
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(registerRoutes, (route) => false);
            },
            child: const Text("Not registered yet? Register here!"),
          ),
        ],
      ),
    );
  }
}
