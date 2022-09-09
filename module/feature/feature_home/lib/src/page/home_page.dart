import 'package:async/async.dart';
import 'package:domain_movie/domain_movie.dart';
import 'package:entity_movie/entity_movie.dart';
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
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (c, t) {
        // context.read<HomeCubit>().fetchMovies();

        return Scaffold(
          appBar: AppBar(title: const Text('Home')),
          body: SafeArea(
            child: ListView(
              children: [
                Text('data'),
                OniTopPicksCard(),
              ],
            )
          ),
        );
      },
    );
  }
}

class HomeState {

}

class HomeCubit extends Cubit<HomeState> {
  final GetMovieUseCase useCase;

  HomeCubit(this.useCase, super.initialState);

  void fetchMovies() async {
    final result = await useCase.getMovies();
    if (result is ValueResult) {
      print((result.asValue.value as MoviesResponse).results?.first.title);
    } else {
      print(result);
    }
  }
}
