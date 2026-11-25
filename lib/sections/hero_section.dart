import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.band,
    required this.emailCopied,
    required this.onReadWork,
    required this.onCopyEmail,
    required this.onOpenUri,
  });

  final ScreenBand band;
  final bool emailCopied;
  final VoidCallback onReadWork;
  final VoidCallback onCopyEmail;
  final Future<void> Function(String url) onOpenUri;

  @override
  Widget build(BuildContext context) {
    final palette = EditorialPalette.of(context);
    final isDesktop = band == ScreenBand.desktop;
    final topPad = switch (band) {
      ScreenBand.desktop => 76.0,
      ScreenBand.tablet => 52.0,
      ScreenBand.mobile => 32.0,
    };
    final bottomPad = switch (band) {
      ScreenBand.desktop => 80.0,
      ScreenBand.tablet => 56.0,
      ScreenBand.mobile => 40.0,
    };

    final headlineFontSize = switch (band) {
      ScreenBand.desktop => 52.0,
      ScreenBand.tablet => 42.0,
      ScreenBand.mobile => 34.0,
    };

    final primaryColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            PortfolioData.heroHeadline,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: headlineFontSize,
            ),
          ),
        ),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            PortfolioData.heroLead,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: band == ScreenBand.mobile ? 15.5 : 17,
            ),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            FilledButton(
              onPressed: onReadWork,
              child: const Text('Read selected work'),
            ),
            OutlinedButton.icon(
              onPressed: onCopyEmail,
              icon: Icon(
                emailCopied ? Icons.check : Icons.content_copy,
                size: 16,
              ),
              label: Text(emailCopied ? 'Email copied' : 'Copy email'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 4,
          children: [
            EditorialTextLink(
              label: 'LinkedIn',
              external: true,
              onPressed: () => onOpenUri(PortfolioData.linkedinUrl),
            ),
            EditorialTextLink(
              label: 'GitHub',
              external: true,
              onPressed: () => onOpenUri(PortfolioData.githubUrl),
            ),
            EditorialTextLink(
              label: PortfolioData.email,
              onPressed: () => onOpenUri('mailto:${PortfolioData.email}'),
            ),
          ],
        ),
      ],
    );

    final factLedger = Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile summary',
            style: TextStyle(
              fontFamily: AppTheme.displayFont,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: palette.ink,
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < PortfolioData.heroLedger.length; i++) ...[
            if (i > 0) Divider(height: 20, thickness: 1, color: palette.hairline),
            Text(
              PortfolioData.heroLedger[i].label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: palette.accent,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              PortfolioData.heroLedger[i].value,
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
                color: palette.ink,
                height: 1.45,
              ),
            ),
          ],
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.only(top: topPad, bottom: bottomPad),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 7, child: primaryColumn),
                const SizedBox(width: 48),
                Expanded(flex: 4, child: factLedger),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                primaryColumn,
                const SizedBox(height: 32),
                factLedger,
              ],
            ),
    );
  }
}
