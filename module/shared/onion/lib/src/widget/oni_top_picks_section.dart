import 'package:flutter/material.dart';
import 'package:onion/onion.dart';
import '/src/style/oni_text.dart';

class OniTopPicksSection extends StatelessWidget {
  final String title;
  final List<TopCard> cards;

  const OniTopPicksSection({
    required this.title,
    required this.cards,
    super.key,
  });

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
