import 'package:e_commerce_app/components/input_fields.dart';
import 'package:e_commerce_app/components/loading_button.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final nameController = TextEditingController(text: '');
  final usernameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> signup() async {
    setState(() {
      isLoading = true;
    });

    final isSignupSuccess =
        await ref.read(authNotifierProvider.notifier).register(
              name: nameController.text,
              username: usernameController.text,
              email: emailController.text,
              password: passwordController.text,
            );

    if (isSignupSuccess) {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/signin', (_) => false);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: alertColor,
          content: const Text(
            'Sign Up failed. Please try again.',
            textAlign: TextAlign.center,
          ),
        ));
      }
    }
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
              'Sign Up',
              style:
                  primaryTextStyle.copyWith(fontSize: 24, fontWeight: semibold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Sign up to continue',
              style:
                  subtitleTextStyle.copyWith(fontSize: 14, fontWeight: regular),
            ),
          ],
        ),
      );
    }

    Widget nameInput() {
      return CustomFormField(
          labelText: 'Full Name',
          formIcon: Icons.person,
          controller: nameController,
          hintText: 'Your Full Name',
          isObscured: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Name cannot be empty";
            } else if (value.length < 3) {
              return "Name must be at least 3 characters";
            }
            return null;
          });
    }

    Widget usernameInput() {
      return CustomFormField(
          labelText: 'Username',
          formIcon: Icons.person_pin,
          controller: usernameController,
          hintText: 'Your Username',
          isObscured: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Username cannot be empty";
            } else if (value.length < 3) {
              return "Username must be at least 3 characters";
            }
            return null;
          });
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

    Widget signUpButton() {
      return Container(
        height: 50,
        margin: const EdgeInsets.only(top: 30),
        child: Row(
          children: [
            Expanded(
                child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  signup();
                }
              },
              style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: Text(
                'Sign Up',
                style: primaryTextStyle.copyWith(fontWeight: semibold),
              ),
            ))
          ],
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account? ',
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Sign in',
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
                nameInput(),
                usernameInput(),
                emailInput(),
                passwordInput(),
                isLoading ? const LoadingButton() : signUpButton(),
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
