import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../models/portfolio_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key, required this.onOpenUri});

  final Future<void> Function(String url) onOpenUri;

  @override
  Widget build(BuildContext context) {
    return SectionBlock(
      eyebrow: '02 / EXPERIENCE',
      title: 'Shipped across product, hardware, and team boundaries.',
      child: Column(
        children: PortfolioData.experiences
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: _ExperienceCard(item: item, onOpenUri: onOpenUri),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({
    required this.item,
    required this.onOpenUri,
  });

  final ExperienceItemData item;
  final Future<void> Function(String url) onOpenUri;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      padding: const EdgeInsets.all(24),
      borderRadius: 22,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final meta = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.mint.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: AppColors.mint.withValues(alpha: 0.25),
                  ),
                ),
                child: Text(
                  item.period,
                  style: const TextStyle(
                    color: AppColors.mint,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.location,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                ),
              ),
            ],
          );

          final content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.role, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(
                item.company,
                style: const TextStyle(
                  color: AppColors.sky,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (item.productLinks.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: item.productLinks
                      .map(
                        (link) => ActionChip(
                          onPressed: () => onOpenUri(link.url),
                          avatar: const Icon(
                            Icons.open_in_new_rounded,
                            size: 14,
                            color: AppColors.mint,
                          ),
                          label: Text('${link.label} · Google Play'),
                          labelStyle: const TextStyle(
                            color: AppColors.text,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                          backgroundColor: AppColors.inkSoft,
                          side: const BorderSide(color: AppColors.borderHover),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
              const SizedBox(height: 14),
              ...item.details.map(
                (detail) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Icon(
                          Icons.circle,
                          size: 6,
                          color: AppColors.mint,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          detail,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: item.techStack
                    .map((tech) => TechChip(tech, compact: true))
                    .toList(),
              ),
            ],
          );

          if (constraints.maxWidth < 740) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [meta, const SizedBox(height: 16), content],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 210, child: meta),
              const SizedBox(width: 16),
              Expanded(child: content),
            ],
          );
        },
      ),
    );
  }
}
