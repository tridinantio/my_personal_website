import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    const edu = PortfolioData.education;
    return SectionBlock(
      eyebrow: '04 / EDUCATION & CREDENTIALS',
      title: 'Grounded in Software Engineering fundamentals.',
      verticalPadding: 48,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final educationCard = HoverCard(
            padding: const EdgeInsets.all(24),
            borderRadius: 22,
            hoverBorderColor: AppColors.mint.withValues(alpha: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.mint.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        color: AppColors.mint,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            edu.university,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            '${edu.location}  ·  ${edu.graduation}',
                            style: const TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  edu.degree,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TechChip('CGPA ${edu.cgpa}', accent: AppColors.mint),
                    TechChip(edu.honors, accent: AppColors.sky),
                  ],
                ),
              ],
            ),
          );

          final credentialsCard = HoverCard(
            padding: const EdgeInsets.all(24),
            borderRadius: 22,
            hoverBorderColor: AppColors.sky.withValues(alpha: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.sky.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.verified_outlined,
                        color: AppColors.sky,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Certifications & Languages',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  'CERTIFICATION',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: AppColors.sky,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  PortfolioData.certification,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'LANGUAGES',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: AppColors.mint,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  PortfolioData.languages,
                  style: TextStyle(
                    fontSize: 14.5,
                    color: AppColors.textMuted,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          );

          if (constraints.maxWidth < 820) {
            return Column(
              children: [
                educationCard,
                const SizedBox(height: 16),
                credentialsCard,
              ],
            );
          }

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 6, child: educationCard),
                const SizedBox(width: 18),
                Expanded(flex: 4, child: credentialsCard),
              ],
            ),
          );
        },
      ),
    );
  }
}
