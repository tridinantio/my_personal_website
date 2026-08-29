import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_personal_website/main.dart';

void main() {
  testWidgets('renders the portfolio landing content', (tester) async {
    await tester.pumpWidget(const PersonalWebsite());

    expect(find.text('TD'), findsOneWidget);
    expect(find.text('Explore my work'), findsOneWidget);
    expect(find.text('ESB POSLite'), findsOneWidget);
    expect(find.text('OLIN by ESB'), findsOneWidget);
    expect(find.text('jobseeker.partners'), findsOneWidget);
  });

  testWidgets('renders without layout errors on a mobile viewport', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const PersonalWebsite());

    expect(find.text('Explore my work'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
