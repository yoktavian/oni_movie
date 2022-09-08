import 'package:flutter/material.dart';
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
              AuthBundle.loginRoute,
              // args: {
              //   AuthBundle.idLoginBundle: '1',
              // },
            );
          },
          child: const Text('Welcome'),
        ),
      ),
    );
  }
}
