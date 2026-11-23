import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/app.dart';

void main() {
  testWidgets('DermAI app opens login screen by default', (tester) async {
    await tester.pumpWidget(const DermAIApp());

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
  });

  testWidgets('successful login transitions to app shell', (tester) async {
    await tester.pumpWidget(const DermAIApp());

    await tester.tap(find.text('Login'));
    await tester.pump();

    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Good morning,'), findsOneWidget);
    expect(find.text('Laila 👋'), findsOneWidget);
  });
}
