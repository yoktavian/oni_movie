import 'package:flutter/material.dart';
import 'package:onion/onion.dart';
import 'package:onion/src/widget/oni_label.dart';

class TopCard extends StatelessWidget {
  final String posterUrl;
  final String title;
  final String releaseDateTitle;
  final String releaseDate;
  final String popularityTitle;
  final String popularity;
  final String overviewTitle;
  final String overview;

  static const imageBaseUrl = 'http://image.tmdb.org/t/p/w500/';

  const TopCard({
    required this.posterUrl,
    required this.title,
    required this.releaseDateTitle,
    required this.releaseDate,
    required this.popularityTitle,
    required this.popularity,
    required this.overviewTitle,
    required this.overview,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 166,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              '$imageBaseUrl$posterUrl',
              loadingBuilder: (_, widget, progress) {
                if (progress == null) return widget;
                return Container(
                  color: OniColor.white,
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: OniTextStyle.h1Bold.copyWith(color: OniColor.white),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              Text(
                releaseDateTitle,
                style: OniTextStyle.bodyBold.copyWith(color: OniColor.white),
              ),
              const SizedBox(height: 4),
              OniLabel(label: releaseDate),
              const SizedBox(height: 12),
              Text(
                popularityTitle,
                style: OniTextStyle.bodyBold.copyWith(color: OniColor.white),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, color: OniColor.flamingo),
                  const SizedBox(width: 4),
                  Text(
                    popularity,
                    style: OniTextStyle.caption.copyWith(color: OniColor.white),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Text(
                overviewTitle,
                style: OniTextStyle.bodyBold.copyWith(color: OniColor.flamingo),
              ),
              const SizedBox(height: 4),
              Text(
                overview,
                style: OniTextStyle.caption.copyWith(color: OniColor.white),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }
}
