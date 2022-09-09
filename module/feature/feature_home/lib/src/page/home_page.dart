import 'package:domain_movie/domain_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onion/onion.dart';

import '/src/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  final GetMovieUseCase Function() getMovieUseCase;

  const HomePage(this.getMovieUseCase, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (create) => HomeCubit(getMovieUseCase(), HomeState()),
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
    context.read<HomeCubit>().fetchMovies();
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
                  content: Text('Gagal memuat, silahkan coba lagi'),
                  backgroundColor: OniColor.red,
                ),
              );
            }
          },
          builder: (_, state) {
            final cards = state.moviesResponse?.results?.map(
              (element) {
                return TopCard(
                  posterUrl: element.posterPath ?? '',
                  title: element.title ?? '',
                  year: element.releaseDate ?? '',
                  popularity: element.popularity.toString(),
                  vote: element.voteAverage?.toInt() ?? 0,
                );
              },
            ).toList();

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                OniTopPicksCard(
                  title: 'Now playing movies',
                  cards: cards ?? [],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
