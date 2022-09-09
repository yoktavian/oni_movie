import 'package:domain_movie/domain_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (c, t) {
        context.read<HomeCubit>().test();

        return Scaffold(
          appBar: AppBar(title: const Text('Home')),
          body: const SafeArea(
            child: Text('Welcome home'),
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

  void test() async {
    final result = await useCase.getMovies();
    print(result);
  }
}