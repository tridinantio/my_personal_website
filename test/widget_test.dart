import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_personal_website/main.dart';

void main() {
  testWidgets('renders Warm Editorial portfolio on desktop with zero em dashes', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1440, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const PersonalWebsite());
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Trinanda Dinantio'), findsOneWidget);
    expect(find.text('Read selected work'), findsOneWidget);
    expect(find.text('ESB POSLite'), findsOneWidget);
    expect(find.text('OLIN by ESB'), findsOneWidget);
    expect(find.text('jobseeker.partners'), findsOneWidget);
    expect(find.text('Jan 2022 to Nov 2022'), findsOneWidget);
    expect(find.text('Universiti Utara Malaysia (UUM)'), findsOneWidget);
    expect(find.textContaining('—'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('toggles between light and dark themes cleanly and copies email', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1440, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const PersonalWebsite());

    expect(find.text('Dark'), findsOneWidget);
    await tester.tap(find.text('Dark'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Light'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Light'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Dark'), findsOneWidget);

    String? copiedText;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copiedText =
              (call.arguments as Map<dynamic, dynamic>)['text'] as String?;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );

    await tester.tap(find.text('Copy email').first);
    await tester.pump(const Duration(milliseconds: 300));
    expect(copiedText, 'tridinantio@gmail.com');
    expect(find.text('Email copied'), findsOneWidget);
  });

  testWidgets('filters selected work and opens technical notes dialog', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1440, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const PersonalWebsite());

    final aiFilter = find.text('AI & voice');
    await tester.ensureVisible(aiFilter);
    await tester.tap(aiFilter);
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('OLIN by ESB'), findsOneWidget);
    expect(find.text('jobseeker.partners'), findsNothing);

    final notesButton = find.text('Technical notes').first;
    await tester.ensureVisible(notesButton);
    await tester.tap(notesButton);
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Engineering contributions'), findsOneWidget);
    await tester.tap(find.text('Close'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Engineering contributions'), findsNothing);
  });

  testWidgets('holds layout on tablet (768px) and mobile (390px) with labeled Menu', (
    tester,
  ) async {
    for (final size in const [Size(768, 1024), Size(390, 844)]) {
      await tester.binding.setSurfaceSize(size);
      await tester.pumpWidget(const PersonalWebsite());
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Menu'), findsOneWidget);
      expect(find.text('Read selected work'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('Menu'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('Navigate'), findsOneWidget);

      await tester.tap(find.byTooltip('Close menu'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('Navigate'), findsNothing);
    }
    addTearDown(() => tester.binding.setSurfaceSize(null));
  });

  testWidgets("fires Made With AI's Love fireworks and per-model bursts cleanly", (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1440, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const PersonalWebsite());

    expect(find.text("Made With AI's Love!"), findsOneWidget);
    expect(find.text('ChatGPT'), findsNothing);

    await tester.tap(find.text("Made With AI's Love!"));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('AI Colophon'), findsOneWidget);
    expect(find.text('ChatGPT'), findsOneWidget);
    expect(find.text('Gemini'), findsOneWidget);

    await tester.tap(find.text('ChatGPT'));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('x2'), findsOneWidget);

    await tester.tap(find.text('Gemini'));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('x3'), findsOneWidget);

    await tester.tap(find.text('Fireworks'));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('x4'), findsOneWidget);

    await tester.tap(find.text('Pause'));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Float on'), findsOneWidget);

    // Let firework particles expire cleanly before tearing down.
    await tester.pump(const Duration(seconds: 3));
    await tester.tap(find.byTooltip('Close AI credits'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('AI Colophon'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
