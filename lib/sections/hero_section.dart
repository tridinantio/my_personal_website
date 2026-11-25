import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.compact,
    required this.onExploreWork,
    required this.onContact,
    required this.onOpenUri,
    required this.onCopyEmail,
  });

  final bool compact;
  final VoidCallback onExploreWork;
  final VoidCallback onContact;
  final Future<void> Function(String url) onOpenUri;
  final VoidCallback onCopyEmail;

  @override
  Widget build(BuildContext context) {
    final displayStyle = Theme.of(context).textTheme.displayLarge!;
    return Padding(
      padding: EdgeInsets.only(
        top: compact ? 44 : 84,
        bottom: compact ? 40 : 68,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (!compact)
            const Positioned(
              right: -20,
              top: -12,
              child: _HeroGlowOrb(),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _StatusPill(),
              const SizedBox(height: 22),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: Text.rich(
                  TextSpan(
                    style: displayStyle.copyWith(
                      fontSize: compact ? 38 : 58,
                      letterSpacing: compact ? -1.4 : -2.2,
                    ),
                    children: const [
                      TextSpan(text: 'Building '),
                      TextSpan(
                        text: 'reliable mobile products',
                        style: TextStyle(color: AppColors.mint),
                      ),
                      TextSpan(text: ' for real-world businesses.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  PortfolioData.heroSubtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: compact ? 15.5 : 18,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: onExploreWork,
                    icon: const Icon(Icons.arrow_downward_rounded, size: 18),
                    label: const Text('Explore my work'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.mint,
                      foregroundColor: AppColors.ink,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: onContact,
                    icon: const Icon(Icons.mail_outline_rounded, size: 18),
                    label: const Text('Contact me'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.text,
                      side: const BorderSide(color: AppColors.borderHover),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  SocialActionPill(
                    icon: Icons.work_outline_rounded,
                    label: 'LinkedIn',
                    onPressed: () => onOpenUri(PortfolioData.linkedinUrl),
                  ),
                  SocialActionPill(
                    icon: Icons.code_rounded,
                    label: 'GitHub',
                    onPressed: () => onOpenUri(PortfolioData.githubUrl),
                  ),
                  SocialActionPill(
                    icon: Icons.copy_rounded,
                    label: PortfolioData.email,
                    onPressed: onCopyEmail,
                  ),
                ],
              ),
              const SizedBox(height: 44),
              const _StatsRow(),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border),
      ),
      child: const Wrap(
        spacing: 8,
        runSpacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(Icons.circle, size: 8, color: AppColors.mint),
          Text(
            'FLUTTER ENGINEER  ·  TANGERANG, INDONESIA',
            style: TextStyle(
              color: AppColors.mint,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroGlowOrb extends StatelessWidget {
  const _HeroGlowOrb();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: 260,
        height: 260,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            colors: [
              Color(0x2E6EE7B7),
              Color(0x147DD3FC),
              Color(0x00070D19),
            ],
          ),
          border: Border.all(color: const Color(0x1E6EE7B7)),
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 820
            ? 4
            : constraints.maxWidth >= 460
                ? 2
                : 1;
        const spacing = 14.0;
        final itemWidth =
            (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: PortfolioData.heroStats
              .map(
                (stat) => SizedBox(
                  width: itemWidth,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stat.value,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.text,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          stat.label,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
