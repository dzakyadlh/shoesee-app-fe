import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: primaryTextColor,
                size: 24,
              )),
          backgroundColor: backgroundPrimaryColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: medium),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.check,
                  color: primaryColor,
                  size: 24,
                )),
          ],
        ),
      );
    }

    Widget contents() {
      return Form(
        child: Column(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/profile_pic_default.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: defaultMargin,
            ),
            TextFormField(
              controller: nameController,
              style: primaryTextStyle.copyWith(fontSize: 16),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: secondaryTextStyle,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: usernameController,
              style: primaryTextStyle.copyWith(fontSize: 16),
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: secondaryTextStyle,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: emailController,
              style: primaryTextStyle.copyWith(fontSize: 16),
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: secondaryTextStyle,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundTertiaryColor,
      resizeToAvoidBottomInset: false,
      appBar: header(),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          children: [contents()],
        ),
      )),
    );
  }
}
