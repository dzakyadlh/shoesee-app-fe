import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class ExpandedFilledButton extends StatelessWidget {
  const ExpandedFilledButton(
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

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.buttonHeight,
    required this.buttonText,
    required this.buttonTextSize,
    required this.onPressed,
  });

  final double buttonHeight;
  final String buttonText;
  final double buttonTextSize;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text(
            buttonText,
            style: primaryTextStyle.copyWith(
                fontSize: buttonTextSize, fontWeight: medium),
          )),
    );
  }
}
