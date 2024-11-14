import 'package:e_commerce_app/components/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/landing_shoe.png'))),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Text(
              'Level up your confidence with our amazing shoes',
              textAlign: TextAlign.center,
              style:
                  primaryTextStyle.copyWith(fontSize: 24, fontWeight: semibold),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              'Shoesee provides you with a whole list of shoes that are on trend in the world',
              textAlign: TextAlign.center,
              style: subtitleTextStyle.copyWith(fontSize: 14),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ExpandedFilledButton(
                buttonText: 'Get Started',
                onPressed: () {
                  Navigator.pushNamed(context, '/signin');
                })
          ],
        ),
      ),
    );
  }
}
