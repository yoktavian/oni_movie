import 'package:domain_movie/domain_movie.dart';
import '/src/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onion/onion.dart';

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
    return BlocBuilder<HomeCubit, HomeState>(
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

        return Scaffold(
          backgroundColor: OniColor.bleachedCedar,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                OniTopPicksCard(
                  title: 'Now playing movies',
                  cards: cards ?? [],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
