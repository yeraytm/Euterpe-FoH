import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class CustomSignInScreen extends StatelessWidget {
  const CustomSignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CustomEmailSignInForm(),
      ),
    );
  }
}

class CustomEmailSignInForm extends StatefulWidget {
  const CustomEmailSignInForm({Key? key}) : super(key: key);

  @override
  State<CustomEmailSignInForm> createState() => _CustomEmailSignInFormState();
}

class _CustomEmailSignInFormState extends State<CustomEmailSignInForm> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthFlowBuilder<EmailFlowController>(
        builder: (context, state, controller, _) {
      if (state is AwaitingEmailAndPassword) {
        return _buildSignInScreen(context, controller, emailCtrl, passwordCtrl);
      } else if (state is SigningIn) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is AuthFailed) {
        return Center(child: ErrorText(exception: state.exception));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}

Widget _buildSignInScreen(BuildContext context, EmailFlowController controller,
    TextEditingController emailCtrl, TextEditingController passwordCtrl) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: TextField(
          decoration: const InputDecoration(labelText: 'Email'),
          controller: emailCtrl,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: TextField(
          decoration: const InputDecoration(labelText: 'Password'),
          controller: passwordCtrl,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          onPressed: () {
            controller.setEmailAndPassword(
              emailCtrl.text,
              passwordCtrl.text,
            );
          },
          child: const Text('Sign In'),
        ),
      ),
      RichText(
        text: TextSpan(
            text: "You don't have an account? ",
            children: [
              TextSpan(
                text: "Register",
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
                  },
              ),
            ],
            style: const TextStyle(color: Colors.black)),
      ),
    ],
  );
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthFlowBuilder<EmailFlowController>(
        builder: (context, state, controller, _) {
      if (state is AwaitingEmailAndPassword) {
        return _buildRegisterScreen(
            context, controller, emailCtrl, passwordCtrl);
      } else if (state is SigningIn) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is AuthFailed) {
        return Center(child: ErrorText(exception: state.exception));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}

Widget _buildRegisterScreen(
    BuildContext context,
    EmailFlowController controller,
    TextEditingController emailCtrl,
    TextEditingController passwordCtrl) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: TextField(
          decoration: const InputDecoration(labelText: 'Email'),
          controller: emailCtrl,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: TextField(
          decoration: const InputDecoration(labelText: 'Password'),
          controller: passwordCtrl,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          onPressed: () {
            controller.setEmailAndPassword(
              emailCtrl.text,
              passwordCtrl.text,
            );
          },
          child: const Text('Register'),
        ),
      ),
      RichText(
        text: TextSpan(
            text: "Already have an account? ",
            children: [
              TextSpan(
                text: "Log In",
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('CLICKED!');
                  },
              ),
            ],
            style: const TextStyle(color: Colors.black)),
      ),
    ],
  );
}
