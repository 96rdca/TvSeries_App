import 'package:flutter/material.dart';
import 'package:seriestv_jobcity/common/enums/apperror_type.dart';

class AppErroWidget extends StatelessWidget {
  final Function() onPressed;
  final AppErrorType errorType;
  const AppErroWidget(
      {Key? key, required this.onPressed, required this.errorType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          errorType == AppErrorType.api
              ? 'Something went wrong...'
              : 'Please check your network connection and press Retry button',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.red),
        ),
        ButtonBar(
          children: [
            TextButton(
              onPressed: onPressed,
              child: const Text('Retry'),
            )
          ],
        )
      ],
    );
  }
}
