import 'package:e_commerce_app/components/filled_button.dart';
import 'package:e_commerce_app/components/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  void login() {
    setState(() {
      email = emailController.text;
      password = passwordController.text;
    });
    if (email == "admin@gmail.com" && password == "admin123") {
      Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style:
                  primaryTextStyle.copyWith(fontSize: 24, fontWeight: semibold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Sign in to continue',
              style:
                  subtitleTextStyle.copyWith(fontSize: 14, fontWeight: regular),
            ),
          ],
        ),
      );
    }

    Widget emailInput() {
      return CustomFormField(
          labelText: 'Email Address',
          formIcon: Icons.mail,
          controller: emailController,
          hintText: 'example@gmail.com',
          isObscured: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Email cannot be empty";
            } else if (!value.contains('@')) {
              return "Please enter a valid email address";
            }
            return null;
          });
    }

    Widget passwordInput() {
      return CustomFormField(
          labelText: 'Password',
          formIcon: Icons.lock,
          controller: passwordController,
          hintText: 'Password',
          isObscured: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Password cannot be empty";
            } else if (value.length < 8) {
              return "Please must be at least 8 characters";
            }
            return null;
          });
    }

    Widget signInButton() {
      return ExpandedFilledButton(
        buttonText: 'Sign In',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            login();
          }
        },
      );
    }

    Widget footer() {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t have an account? ',
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  'Sign up',
                  style: buttonTextStyle.copyWith(fontSize: 12),
                ))
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                header(),
                const SizedBox(
                  height: 70,
                ),
                emailInput(),
                passwordInput(),
                signInButton(),
                const Spacer(),
                footer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
