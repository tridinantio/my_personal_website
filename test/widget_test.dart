import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_personal_website/main.dart';

void main() {
  testWidgets('renders synced portfolio sections, dates, and live apps', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1440, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const PersonalWebsite());

    expect(find.text('TD'), findsOneWidget);
    expect(find.text('Explore my work'), findsOneWidget);
    expect(find.text('Download ATS CV'), findsNothing);
    expect(find.text('Jan 2022 — Nov 2022'), findsOneWidget);
    expect(find.text('Nov 2023 — Present'), findsOneWidget);
    expect(find.text('ESB POSLite'), findsOneWidget);
    expect(find.text('OLIN by ESB'), findsOneWidget);
    expect(find.text('jobseeker.partners'), findsOneWidget);
    expect(find.text('Universiti Utara Malaysia (UUM)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('opens project highlights dialog cleanly', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const PersonalWebsite());

    final highlightsButton = find.text('Highlights').first;
    await tester.ensureVisible(highlightsButton);
    await tester.tap(highlightsButton);
    await tester.pumpAndSettle();

    expect(find.text('ENGINEERING HIGHLIGHTS'), findsOneWidget);
    expect(find.text('Open on Google Play'), findsOneWidget);

    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    expect(find.text('ENGINEERING HIGHLIGHTS'), findsNothing);
  });

  testWidgets('renders without layout errors on a mobile viewport', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const PersonalWebsite());

    expect(find.text('Explore my work'), findsOneWidget);
    expect(find.byTooltip('Open navigation menu'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
