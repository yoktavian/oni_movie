import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:oni_router/oni_router.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnBoardingView();
  }
}

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding'),
      ),
      body: SafeArea(
        child: InkWell(
          onTap: () {
            OniRouter.pushName(
              context,
              HomeRoutes.home,
              args: {
                AuthBundles.idLogin: '1',
              },
            );
          },
          child: const Text('Welcome'),
        ),
      ),
    );
  }
}
