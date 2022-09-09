import 'package:flutter/material.dart';
import 'package:onion/onion.dart';
import 'package:onion/src/widget/oni_label.dart';

class OniUpcomingMovieCard extends StatelessWidget {
  static const imageBaseUrl = 'http://image.tmdb.org/t/p/w500/';
  static const double size4 = 4;
  static const double size16 = 16;
  static const double cartHeight = 90;
  static const double posterWidth = 59; // based on aspect ratio from the image.

  final String posterUrl;
  final String title;
  final String releaseDate;

  const OniUpcomingMovieCard({
    required this.posterUrl,
    required this.title,
    required this.releaseDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: cartHeight,
          width: posterWidth,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size4),
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
        const SizedBox(width: size16),
        Expanded(
          child: Container(
            height: cartHeight,
            padding: const EdgeInsets.all(size16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size4),
              gradient: const LinearGradient(
                colors: [
                  OniColor.mineShaft,
                  OniColor.bleachedCedar,
                ],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: OniTextStyle.body.copyWith(color: OniColor.white),
                  ),
                ),
                const SizedBox(width: 4),
                OniLabel(label: releaseDate),
              ],
            )
          ),
        ),
      ],
    );
  }
}
