import 'package:domain_movie/domain_movie.dart';
import 'package:feature_search/src/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:oni_router/oni_router.dart';
import 'package:onion/onion.dart';

class SearchResultPage extends StatelessWidget {
  final SearchMovieUseCase Function() searchMovieUseCase;

  const SearchResultPage({required this.searchMovieUseCase, super.key});

  @override
  Widget build(BuildContext context) {
    final keywords = context.get<String>(SearchBundles.searchKeywords);

    return BlocProvider(
      create: (_) => SearchCubit(
        searchMovieUseCase(),
        SearchState(keywords: keywords),
      )..search(),
      child: const SearchResultView(),
    );
  }
}

class SearchResultView extends StatelessWidget {
  static const loadingKey = Key('loading-widget');
  static const snackBarErrorKey = Key('snackbar-widget');
  static const headerSectionKey = Key('header-widget');
  static const backKey = Key('back-widget');
  static const searchResultTitleKey = Key('search-result-title-widget');
  static const searchResultSection = Key('search-result-section-widget');

  const SearchResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OniColor.bleachedCedar,
      body: SafeArea(
        child: BlocConsumer<SearchCubit, SearchState>(
          listener: (_, state) {
            if (state.loadingState == SearchLoadingState.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to search movie'),
                  backgroundColor: OniColor.red,
                  key: snackBarErrorKey,
                ),
              );
            }
          },
          builder: (_, state) {
            if (state.loadingState == SearchLoadingState.loading) {
              return const Center(
                child: CircularProgressIndicator(key: loadingKey),
              );
            }

            final cards = state.movies?.results?.map(
                  (movie) {
                return OniMovieCard(
                  posterUrl: movie.posterPath ?? '',
                  title: movie.title ?? '',
                  releaseDate: movie.releaseDate ?? '',
                );
              },
            ).toList() ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  key: headerSectionKey,
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          OniRouter.pop(context);
                        },
                        key: backKey,
                        child: const Icon(
                          Icons.arrow_back_ios_outlined,
                          color: OniColor.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Find ${state.movies?.results?.length} result for ${state.keywords} keywords',
                          style: OniTextStyle.body.copyWith(color: OniColor.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          key: searchResultTitleKey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (_, index) {
                      return cards[index];
                    },
                    separatorBuilder: (_, __) {
                      return const SizedBox(height: 8);
                    },
                    itemCount: cards.length,
                    key: searchResultSection,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
