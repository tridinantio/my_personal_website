import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../models/portfolio_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({
    super.key,
    required this.band,
    required this.onOpenUri,
  });

  final ScreenBand band;
  final Future<void> Function(String url) onOpenUri;

  @override
  Widget build(BuildContext context) {
    final palette = EditorialPalette.of(context);
    final verticalPad = switch (band) {
      ScreenBand.desktop => 64.0,
      ScreenBand.tablet => 48.0,
      ScreenBand.mobile => 36.0,
    };

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EditorialSectionHeader(
            index: '02',
            title: 'Experience',
            subtitle:
                'Production Flutter engineering roles across F&B point of sale, recruitment, and contract mobile builds.',
          ),
          for (var i = 0; i < PortfolioData.experiences.length; i++) ...[
            _ExperienceLedgerRow(
              entry: PortfolioData.experiences[i],
              band: band,
              onOpenUri: onOpenUri,
            ),
            if (i < PortfolioData.experiences.length - 1)
              Divider(height: 1, thickness: 1, color: palette.hairline),
          ],
        ],
      ),
    );
  }
}

class _ExperienceLedgerRow extends StatelessWidget {
  const _ExperienceLedgerRow({
    required this.entry,
    required this.band,
    required this.onOpenUri,
  });

  final ExperienceEntry entry;
  final ScreenBand band;
  final Future<void> Function(String url) onOpenUri;

  @override
  Widget build(BuildContext context) {
    final palette = EditorialPalette.of(context);
    final isDesktop = band == ScreenBand.desktop;

    final timelineColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entry.period,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: palette.accent,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          entry.location,
          style: TextStyle(fontSize: 13.5, color: palette.inkMuted),
        ),
      ],
    );

    final detailsColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(entry.role, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 3),
        Text(
          entry.company,
          style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w600,
            color: palette.inkMuted,
          ),
        ),
        if (entry.productLinks.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: entry.productLinks
                .map(
                  (link) => EditorialTextLink(
                    label: link.label,
                    external: true,
                    emphasize: true,
                    onPressed: () => onOpenUri(link.url),
                  ),
                )
                .toList(),
          ),
        ],
        const SizedBox(height: 12),
        for (final bullet in entry.details)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- ',
                  style: TextStyle(
                    color: palette.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Text(
                    bullet,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: palette.ink,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Stack: ',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: palette.ink,
                ),
              ),
              TextSpan(
                text: entry.stackSummary,
                style: TextStyle(
                  fontSize: 13.5,
                  color: palette.inkMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isDesktop ? 30 : 22),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 230, child: timelineColumn),
                const SizedBox(width: 28),
                Expanded(child: detailsColumn),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                timelineColumn,
                const SizedBox(height: 12),
                detailsColumn,
              ],
            ),
    );
  }
}
