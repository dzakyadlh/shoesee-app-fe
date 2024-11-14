import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile(
      {super.key, required this.settingsText, required this.onTap});

  final String settingsText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              settingsText,
              style: subtitleTextStyle.copyWith(fontSize: 13),
            ),
            Icon(
              Icons.navigate_next,
              size: 20,
              color: secondaryTextColor,
            )
          ],
        ),
      ),
    );
  }
}
