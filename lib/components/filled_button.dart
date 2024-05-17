import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class FilledExpandedButton extends StatelessWidget {
  const FilledExpandedButton(
      {super.key, required this.buttonText, required this.onPressed});

  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Expanded(
              child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            child: Text(
              buttonText,
              style: primaryTextStyle.copyWith(fontWeight: semibold),
            ),
          ))
        ],
      ),
    );
  }
}
