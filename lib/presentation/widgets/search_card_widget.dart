import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seriestv_jobcity/data/models/params/search_params.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_text.dart';

class SearchCard extends StatelessWidget {
  final SearchParams searchParams;

  const SearchCard({
    Key? key,
    required this.searchParams,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          height: 180,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: searchParams.image ?? '',
              fit: BoxFit.cover,
              placeholder: (context, text) {
                return LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: Colors.black.withOpacity(0.5),
                );
              },
              errorWidget: (context, error, stack) {
                return const Icon(
                  Icons.image_not_supported_outlined,
                  size: 40,
                );
              },
              width: 120,
            ),
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                searchParams.name,
                style: Theme.of(context).textTheme.greySubtitle1.copyWith(
                    color: AppColor.vulcan, fontWeight: FontWeight.w400),
              ),
            ),
            Text(
              searchParams.summary ?? '',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.vulcanBodyText2,
            )
          ],
        ))
      ]),
    );
  }
}
