import 'package:flutter/material.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 12),
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColor.grey,
          AppColor.vulcan,
        ]),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
