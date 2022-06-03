import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';

class ImageWidget extends StatelessWidget {
  final String image;
  final double height;
  const ImageWidget({Key? key, required this.image, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            AppColor.grey.withOpacity(0.3),
            Colors.black.withOpacity(0.7)
          ])),
      child: CachedNetworkImage(
        imageUrl: image,
        placeholder: (context, text) {
          return LinearProgressIndicator(
            backgroundColor: Colors.transparent,
            color: Colors.black.withOpacity(0.1),
          );
        },
        placeholderFadeInDuration: const Duration(milliseconds: 400),
        fit: BoxFit.cover,
        errorWidget: (context, error, stack) {
          return const Icon(
            Icons.image_not_supported_outlined,
            size: 100,
            color: Colors.white,
          );
        },
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
