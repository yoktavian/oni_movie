import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oni_router/oni_router.dart';

/// this is just a helper when our screen expect to have a data
/// from the previous screen, so need to use this pump to set
/// the arguments.
Future<void> pumpWidgetWithArguments(
  WidgetTester tester, {
  required Map<String, dynamic> args,
  required Widget child,
  required String route,
}) async {
  final key = GlobalKey<NavigatorState>();
  await tester.pumpWidget(
    MaterialApp(
      navigatorKey: key,
      home: GestureDetector(
        onTap: () {
          final context = key.currentContext;
          if (context != null) {
            OniRouter.pushName(
              context,
              route,
              args: args,
            );
          }
        },
        child: const Text(''),
      ),
      routes: {
        route: (_) => child,
      },
    ),
  );

  await tester.tap(find.byType(GestureDetector));
  await tester.pumpAndSettle();
}
