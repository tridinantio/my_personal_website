import 'dart:ui';

import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class StickyNavBar extends StatelessWidget {
  const StickyNavBar({
    super.key,
    required this.compact,
    required this.onTop,
    required this.onAbout,
    required this.onExperience,
    required this.onProjects,
    required this.onEducation,
    required this.onContact,
  });

  final bool compact;
  final VoidCallback onTop;
  final VoidCallback onAbout;
  final VoidCallback onExperience;
  final VoidCallback onProjects;
  final VoidCallback onEducation;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.ink.withValues(alpha: 0.84),
            border: const Border(
              bottom: BorderSide(color: AppColors.border),
            ),
          ),
          child: SiteShell(
            child: SizedBox(
              height: 70,
              child: Row(
                children: [
                  InkWell(
                    onTap: onTop,
                    borderRadius: BorderRadius.circular(14),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                      child: compact
                          ? const _Monogram()
                          : const _BrandMark(),
                    ),
                  ),
                  if (compact) const Spacer() else const SizedBox(width: 16),
                  if (!compact) ...[
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _NavButton(label: 'About', onTap: onAbout),
                              _NavButton(
                                label: 'Experience',
                                onTap: onExperience,
                              ),
                              _NavButton(label: 'Projects', onTap: onProjects),
                              _NavButton(
                                label: 'Education',
                                onTap: onEducation,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  FilledButton(
                    onPressed: onContact,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.mint,
                      foregroundColor: AppColors.ink,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    child: const Text("Let's talk"),
                  ),
                  if (compact) ...[
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      tooltip: 'Open navigation menu',
                      color: AppColors.surfaceElevated,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: AppColors.border),
                      ),
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: AppColors.text,
                      ),
                      onSelected: (value) {
                        switch (value) {
                          case 'about':
                            onAbout();
                          case 'experience':
                            onExperience();
                          case 'projects':
                            onProjects();
                          case 'education':
                            onEducation();
                          case 'contact':
                            onContact();
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: 'about', child: Text('About & Skills')),
                        PopupMenuItem(value: 'experience', child: Text('Experience')),
                        PopupMenuItem(value: 'projects', child: Text('Selected Work')),
                        PopupMenuItem(value: 'education', child: Text('Education')),
                        PopupMenuDivider(),
                        PopupMenuItem(value: 'contact', child: Text('Contact')),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Monogram extends StatelessWidget {
  const _Monogram();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: const Text(
        PortfolioData.monogram,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: AppColors.mint,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Monogram(),
        SizedBox(width: 11),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TRINANDA DINANTIO',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1,
                color: AppColors.text,
              ),
            ),
            Text(
              'Flutter Engineer',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.textMuted,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}
