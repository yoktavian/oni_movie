import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:oni_router/oni_router.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final keywords = context.get<String>(SearchBundles.searchKeywords);
    return SearchResultView();
  }
}

class SearchResultView extends StatelessWidget {
  const SearchResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('Search result page'),
      ),
    );
  }
}