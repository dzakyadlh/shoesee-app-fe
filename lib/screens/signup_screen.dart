import 'package:e_commerce_app/components/custom_buttons.dart';
import 'package:e_commerce_app/components/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String username = '';
  String email = '';
  String password = '';

  void signup() {
    setState(() {
      name = nameController.text;
      username = usernameController.text;
      email = emailController.text;
      password = passwordController.text;
    });

    Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
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
          controller: emailController,
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
      return ExpandedFilledButton(
        buttonText: 'Sign Up',
        onPressed: () {
          // if (_formKey.currentState!.validate()) {
          //   signup();
          // }
          signup();
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
                signUpButton(),
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
