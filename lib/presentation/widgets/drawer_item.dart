import 'package:flutter/material.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';

class DrawerListItem extends StatelessWidget {
  const DrawerListItem({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);
  final String title;
  final Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColor.vulcan.withOpacity(0.7),
              blurRadius: 2,
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          title: Text(title, style: Theme.of(context).textTheme.subtitle1),
        ),
      ),
    );
  }
}

class NavigationSubListItem extends StatelessWidget {
  const NavigationSubListItem({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              blurRadius: 2,
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 32),
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    );
  }
}
