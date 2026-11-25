import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key, required this.band});

  final ScreenBand band;

  @override
  Widget build(BuildContext context) {
    const edu = PortfolioData.education;
    final palette = EditorialPalette.of(context);
    final isDesktop = band == ScreenBand.desktop;
    final verticalPad = switch (band) {
      ScreenBand.desktop => 56.0,
      ScreenBand.tablet => 44.0,
      ScreenBand.mobile => 32.0,
    };

    final degreeBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${edu.location}  ·  ${edu.graduation}',
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: palette.accent,
          ),
        ),
        const SizedBox(height: 6),
        Text(edu.university, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 6),
        Text(
          edu.degree,
          style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w500,
            color: palette.ink,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'CGPA ${edu.cgpa}  ·  ${edu.honors}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );

    final credentialsBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Certification',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: palette.accent,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          PortfolioData.certification,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: palette.ink,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Languages',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: palette.accent,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          PortfolioData.languages,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: palette.ink,
          ),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EditorialSectionHeader(
            index: '04',
            title: 'Education & background',
          ),
          const SizedBox(height: 28),
          if (isDesktop)
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: degreeBlock),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: palette.hairline,
                    ),
                  ),
                  Expanded(flex: 4, child: credentialsBlock),
                ],
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                degreeBlock,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  child: Divider(height: 1, color: palette.hairline),
                ),
                credentialsBlock,
              ],
            ),
        ],
      ),
    );
  }
}
