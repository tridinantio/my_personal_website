import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../models/portfolio_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.band});

  final ScreenBand band;

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
            index: '03',
            title: 'Technical stack',
            subtitle:
                'Core mobile engineering stack alongside backend, hardware, and workflow tools used in production.',
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: palette.hairline),
            ),
            child: Column(
              children: [
                for (var i = 0; i < PortfolioData.stackRows.length; i++) ...[
                  _StackIndexRow(
                    row: PortfolioData.stackRows[i],
                    band: band,
                  ),
                  if (i < PortfolioData.stackRows.length - 1)
                    Divider(height: 1, thickness: 1, color: palette.hairline),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StackIndexRow extends StatelessWidget {
  const _StackIndexRow({required this.row, required this.band});

  final StackRow row;
  final ScreenBand band;

  @override
  Widget build(BuildContext context) {
    final palette = EditorialPalette.of(context);
    final wide = band != ScreenBand.mobile;

    final categoryText = Text(
      row.category,
      style: TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w600,
        color: palette.ink,
      ),
    );

    final itemsText = Text(
      row.items.join(', '),
      style: TextStyle(
        fontSize: 14.5,
        color: palette.inkMuted,
        height: 1.55,
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: band == ScreenBand.mobile ? 18 : 24,
        vertical: 16,
      ),
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                SizedBox(width: 240, child: categoryText),
                const SizedBox(width: 24),
                Expanded(child: itemsText),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                categoryText,
                const SizedBox(height: 5),
                itemsText,
              ],
            ),
    );
  }
}
