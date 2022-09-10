import 'package:domain_movie/domain_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      ),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OniColor.bleachedCedar,
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (_, state) {
            if (state.homeLoadingState == HomeLoadingState.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to load some data, please try again'),
                  backgroundColor: OniColor.red,
                ),
              );
            }
          },
          builder: (_, state) {
            if (state.homeLoadingState == HomeLoadingState.loading) {
              return const Center(child: CircularProgressIndicator());
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
                    title: 'Search movie',
                    placeholder: 'Input keywords',
                    onSubmitted: (keywords) {
                      print(keywords);
                    },
                  ),
                  const SizedBox(height: 16),
                  OniTopPicksSection(
                    title: 'Now playing movies',
                    cards: cards ?? [],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Upcoming Movies',
                    style: OniTextStyle.h2.copyWith(
                      color: OniColor.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (_, index) {
                        final movie = state.upcomingMoviesData?.results?[index];
                        return OniUpcomingMovieCard(
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
