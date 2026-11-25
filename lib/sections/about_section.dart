import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../models/portfolio_models.dart';
import '../widgets/common_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBlock(
      eyebrow: '01 / ABOUT & TECHNICAL STACK',
      title: 'A product-minded Flutter engineer focused on reliability.',
      subtitle: PortfolioData.aboutParagraph,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 900
              ? 3
              : constraints.maxWidth >= 560
                  ? 2
                  : 1;
          const spacing = 16.0;
          final groups = PortfolioData.skillGroups;

          if (columns == 1) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < groups.length; i++) ...[
                  _SkillGroupCard(group: groups[i]),
                  if (i < groups.length - 1) const SizedBox(height: spacing),
                ],
              ],
            );
          }

          final rows = <Widget>[];
          for (var i = 0; i < groups.length; i += columns) {
            final rowItems = groups.sublist(
              i,
              i + columns > groups.length ? groups.length : i + columns,
            );
            rows.add(
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var j = 0; j < columns; j++) ...[
                      Expanded(
                        child: j < rowItems.length
                            ? _SkillGroupCard(group: rowItems[j])
                            : const SizedBox.shrink(),
                      ),
                      if (j < columns - 1) const SizedBox(width: spacing),
                    ],
                  ],
                ),
              ),
            );
            if (i + columns < groups.length) {
              rows.add(const SizedBox(height: spacing));
            }
          }

          return Column(children: rows);
        },
      ),
    );
  }
}

class _SkillGroupCard extends StatelessWidget {
  const _SkillGroupCard({required this.group});

  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      padding: const EdgeInsets.all(20),
      borderRadius: 20,
      hoverBorderColor: group.accent.withValues(alpha: 0.55),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: group.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(group.icon, size: 18, color: group.accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  group.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: group.skills.map((s) => TechChip(s)).toList(),
          ),
        ],
      ),
    );
  }
}
