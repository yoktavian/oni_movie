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
      ),
      child: const SearchResultView(),
    );
  }
}

class SearchResultView extends StatefulWidget {
  const SearchResultView({super.key});

  @override
  State<SearchResultView> createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView> {
  @override
  void initState() {
    super.initState();
    context.read<SearchCubit>().search();
  }

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
                ),
              );
            }
          },
          builder: (_, state) {
            if (state.loadingState == SearchLoadingState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
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
                Row(
                  children: [

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          OniRouter.pop(context);
                        },
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
