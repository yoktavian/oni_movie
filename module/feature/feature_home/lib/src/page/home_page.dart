import 'package:domain_movie/domain_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:oni_router/oni_router.dart';
import 'package:onion/onion.dart';

import '/src/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  final GetNowPlayingMoviesUseCase Function() getNowPlayingMoviesUseCase;
  final GetUpComingMoviesUseCase Function() getUpComingMoviesUseCase;

  const HomePage(
    this.getNowPlayingMoviesUseCase,
    this.getUpComingMoviesUseCase, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (create) => HomeCubit(
        getNowPlayingMoviesUseCase(),
        getUpComingMoviesUseCase(),
        HomeState(),
      )..loadMovies(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  static const loadingKey = Key('loading-widget');
  static const snackBarErrorKey = Key('snackbar-widget');
  static const searchBarKey = Key('search-bar-widget');
  static const nowPlayingSectionKey = Key('now-playing-section-widget');
  static const upcomingTitleKey = Key('upcoming-title-widget');
  static const upcomingSectionKey = Key('upcoming-section-widget');

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OniColor.bleachedCedar,
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (_, state) {
            if (state.homeLoadingState == HomeLoadingState.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  key: HomeView.snackBarErrorKey,
                  content: Text(state.errorMessage ?? 'failed to load'),
                  backgroundColor: OniColor.red,
                ),
              );
            }
          },
          builder: (_, state) {
            if (state.homeLoadingState == HomeLoadingState.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  key: HomeView.loadingKey,
                ),
              );
            }

            final cards = state.nowPlayingMoviesData?.results?.map(
              (movie) {
                return TopCard(
                  posterUrl: movie.posterPath ?? '',
                  title: movie.title ?? '',
                  releaseDateTitle: 'Release',
                  releaseDate: movie.releaseDate ?? '',
                  popularityTitle: 'Popularity',
                  popularity: movie.popularity.toString(),
                  overviewTitle: 'Overview',
                  overview: movie.overview ?? '',
                );
              },
            ).toList();

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OniSearchBar(
                    key: HomeView.searchBarKey,
                    title: 'Search movie',
                    placeholder: 'Input keywords',
                    onSubmitted: (keywords) {
                      OniRouter.pushName(
                        context,
                        SearchRoutes.searchResult,
                        args: {
                          SearchBundles.searchKeywords: keywords,
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  OniTopPicksSection(
                    key: HomeView.nowPlayingSectionKey,
                    title: 'Now playing movies',
                    cards: cards ?? [],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Upcoming Movies',
                    key: HomeView.upcomingTitleKey,
                    style: OniTextStyle.h2.copyWith(
                      color: OniColor.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      key: HomeView.upcomingSectionKey,
                      itemBuilder: (_, index) {
                        final movie = state.upcomingMoviesData?.results?[index];
                        return OniMovieCard(
                          posterUrl: movie?.posterPath ?? '',
                          title: movie?.title ?? '',
                          releaseDate: movie?.releaseDate ?? '',
                        );
                      },
                      separatorBuilder: (_, __) {
                        return const SizedBox(height: 8);
                      },
                      itemCount: state.upcomingMoviesData?.results?.length ?? 0,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
