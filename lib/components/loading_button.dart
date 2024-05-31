import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Expanded(
              child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(primaryTextColor),
                    )),
                Text(
                  'Loading',
                  style: primaryTextStyle.copyWith(fontWeight: semibold),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
