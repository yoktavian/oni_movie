import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onion/onion.dart';
import 'package:onion/src/style/oni_text.dart';

class OniTopPicksCard extends StatelessWidget {
  final String title;
  final List<TopCard> cards;

  const OniTopPicksCard({required this.title, required this.cards, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: OniTextStyle.h2.copyWith(color: OniColor.white),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              return cards[index];
            },
            separatorBuilder: (_, __) {
              return const SizedBox(width: 16);
            },
            itemCount: cards.length,
          ),
        )
      ],
    );
  }
}

class TopCard extends StatelessWidget {
  final String posterUrl;
  final String title;
  final String year;
  final String popularity;
  final int vote;

  static const imageBaseUrl = 'http://image.tmdb.org/t/p/w500/';

  const TopCard({
    required this.posterUrl,
    required this.title,
    required this.year,
    required this.popularity,
    required this.vote,
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
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: OniTextStyle.h1Bold.copyWith(color: OniColor.white),
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              Text(
                'Release',
                style: OniTextStyle.caption.copyWith(color: OniColor.white),
              ),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: OniColor.flamingo,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.all(4),
                child: Text(
                  year,
                  style: OniTextStyle.caption.copyWith(color: OniColor.white),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Popularity',
                style: OniTextStyle.body.copyWith(color: OniColor.white),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, color: OniColor.red),
                  const SizedBox(width: 4),
                  Text(
                    popularity,
                    style: OniTextStyle.caption.copyWith(color: OniColor.white),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
