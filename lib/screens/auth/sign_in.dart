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
  final fullnameCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  AuthAction _action = AuthAction.signIn;
  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    fullnameCtrl.dispose();
    usernameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthFlowBuilder<EmailFlowController>(
        action: _action,
        builder: (context, state, controller, _) {
          if (state is AwaitingEmailAndPassword) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _action == AuthAction.signIn
                    ? _buildSignInForm(emailCtrl, passwordCtrl)
                    : _buildRegisterForm(
                        emailCtrl, passwordCtrl, fullnameCtrl, usernameCtrl),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.setEmailAndPassword(
                        emailCtrl.text,
                        passwordCtrl.text,
                      );
                    },
                    child: Text(
                        _action == AuthAction.signIn ? 'Sign In' : 'Register'),
                  ),
                ),
                RichText(
                  text: TextSpan(
                      text: _action == AuthAction.signIn
                          ? "You don't have an account? "
                          : "Already have an account? ",
                      children: [
                        TextSpan(
                          text: _action == AuthAction.signIn
                              ? "Register"
                              : "Log In",
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _handleDifferentAuthAction(context);
                            },
                        ),
                      ],
                      style: const TextStyle(color: Colors.black)),
                ),
              ],
            );
          } else if (state is SigningIn) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthFailed) {
            return Center(child: ErrorText(exception: state.exception));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  void _handleDifferentAuthAction(BuildContext context) {
    if (_action == AuthAction.signIn) {
      setState(() {
        _action = AuthAction.signUp;
      });
    } else {
      setState(() {
        _action = AuthAction.signIn;
      });
    }
  }

  Widget _buildSignInForm(
    TextEditingController emailCtrl,
    TextEditingController passwordCtrl,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Text(
            'Sign In',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
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
      ],
    );
  }

  Widget _buildRegisterForm(
      TextEditingController emailCtrl,
      TextEditingController passwordCtrl,
      TextEditingController fullnameCtrl,
      TextEditingController usernameCtrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Text(
            'Register',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: TextField(
            decoration: const InputDecoration(labelText: 'Fullname'),
            controller: fullnameCtrl,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: TextField(
            decoration: const InputDecoration(labelText: 'Username'),
            controller: usernameCtrl,
          ),
        ),
      ],
    );
  }
}
