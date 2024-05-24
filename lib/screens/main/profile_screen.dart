import 'package:e_commerce_app/components/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: backgroundPrimaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
            child: Container(
          padding: EdgeInsets.all(defaultMargin),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/profile_pic_default.png',
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, User!',
                    style: primaryTextStyle.copyWith(
                        fontSize: 24, fontWeight: semibold),
                  ),
                  Text(
                    '@username',
                    style: subtitleTextStyle.copyWith(fontSize: 16),
                  )
                ],
              )),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/sign_in', (route) => false);
                },
                child: Image.asset(
                  'assets/images/exit_button.png',
                  width: 20,
                  height: 20,
                ),
              )
            ],
          ),
        )),
      );
    }

    Widget settings() {
      return Container(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: semibold),
            ),
            const SizedBox(
              height: 16,
            ),
            SettingsTile(
                settingsText: 'Edit Profile',
                onTap: () {
                  Navigator.pushNamed(context, '/edit-profile');
                }),
            SettingsTile(settingsText: 'Your Orders', onTap: () {}),
            SettingsTile(settingsText: 'Help', onTap: () {}),
            const SizedBox(
              height: 10,
            ),
            Text(
              'General',
              style:
                  primaryTextStyle.copyWith(fontSize: 18, fontWeight: semibold),
            ),
            const SizedBox(
              height: 16,
            ),
            SettingsTile(settingsText: 'Privacy & Policy', onTap: () {}),
            SettingsTile(settingsText: 'Terms of Service', onTap: () {}),
            SettingsTile(settingsText: 'Rate Our App', onTap: () {}),
          ],
        ),
      );
    }

    return Container(
      color: backgroundTertiaryColor,
      child: Column(
        children: [header(), settings()],
      ),
    );
  }
}
