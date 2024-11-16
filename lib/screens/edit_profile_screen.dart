import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authNotifierProvider).value;

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
          backgroundColor: backgroundTertiaryColor,
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

    Widget profilePicture() {
      return ClipOval(
        child: Image.network(
          user!.photoUrl.toString(),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      );
    }

    Widget inputFields() {
      return Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: secondaryTextStyle.copyWith(fontSize: 13),
            ),
            TextFormField(
              controller: nameController,
              style: primaryTextStyle.copyWith(fontSize: 16),
              decoration: InputDecoration(
                hintText: user?.name,
                hintStyle: primaryTextStyle,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Username',
              style: secondaryTextStyle.copyWith(fontSize: 13),
            ),
            TextFormField(
              controller: usernameController,
              style: primaryTextStyle.copyWith(fontSize: 16),
              decoration: InputDecoration(
                hintText: user?.username,
                hintStyle: primaryTextStyle,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Email Address',
              style: secondaryTextStyle.copyWith(fontSize: 13),
            ),
            TextFormField(
              controller: emailController,
              style: primaryTextStyle.copyWith(fontSize: 16),
              decoration: InputDecoration(
                hintText: user?.email,
                hintStyle: primaryTextStyle,
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
      backgroundColor: backgroundPrimaryColor,
      resizeToAvoidBottomInset: false,
      appBar: header(),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          children: [
            profilePicture(),
            SizedBox(
              height: defaultMargin,
            ),
            inputFields()
          ],
        ),
      )),
    );
  }
}
