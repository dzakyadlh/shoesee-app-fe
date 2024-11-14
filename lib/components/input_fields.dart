import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    required this.labelText,
    required this.formIcon,
    required this.controller,
    required this.hintText,
    required this.isObscured,
    required this.validator,
  });

  final String labelText;
  final IconData? formIcon;
  final TextEditingController? controller;
  final String hintText;
  final bool isObscured;
  final String? Function(String?)? validator;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.labelText,
              style:
                  primaryTextStyle.copyWith(fontSize: 16, fontWeight: semibold),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundSecondaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: Row(
                children: [
                  Icon(
                    widget.formIcon,
                    color: primaryColor,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: widget.controller,
                    style: primaryTextStyle,
                    obscureText: widget.isObscured,
                    decoration: InputDecoration.collapsed(
                        hintText: widget.hintText,
                        hintStyle: subtitleTextStyle),
                    validator: widget.validator,
                    cursorColor: primaryColor,
                  ))
                ],
              )),
            ),
          ],
        ));
  }
}
