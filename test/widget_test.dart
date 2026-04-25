import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_vault/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(isLoggedIn: false, initialLocale: Locale('en')));

    expect(find.byType(MyApp), findsOneWidget);
  });
}
