import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    required this.onOpenUri,
    required this.onCopyEmail,
  });

  final Future<void> Function(String url) onOpenUri;
  final VoidCallback onCopyEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 56, bottom: 36),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.mint, Color(0xFF4ADEA8)],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EyebrowLabel(
            text: 'OPEN TO FLUTTER & MOBILE OPPORTUNITIES',
            dark: true,
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              "Let's build a reliable mobile experience together.",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.ink,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              'Available for Mid–Senior Flutter Engineer roles (onsite, hybrid, or remote). Reach out directly via email or LinkedIn—resume available upon request.',
              style: TextStyle(
                color: AppColors.ink.withValues(alpha: 0.8),
                fontSize: 15,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              FilledButton.icon(
                onPressed: () => onOpenUri('mailto:${PortfolioData.email}'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.ink,
                  foregroundColor: AppColors.text,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(fontWeight: FontWeight.w700),
                ),
                icon: const Icon(Icons.mail_outline_rounded, size: 18),
                label: const Text(PortfolioData.email),
              ),
              SocialActionPill(
                icon: Icons.copy_rounded,
                label: 'Copy Email',
                onPressed: onCopyEmail,
                dark: true,
              ),
              SocialActionPill(
                icon: Icons.work_outline_rounded,
                label: 'LinkedIn',
                onPressed: () => onOpenUri(PortfolioData.linkedinUrl),
                dark: true,
              ),
              SocialActionPill(
                icon: Icons.code_rounded,
                label: 'GitHub',
                onPressed: () => onOpenUri(PortfolioData.githubUrl),
                dark: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 36, top: 8),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 20,
          runSpacing: 8,
          children: [
            const Text(
              '© 2026 Trinanda Dinantio · Tangerang, Indonesia',
              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
            Text(
              'Built with Flutter Web',
              style: TextStyle(
                color: AppColors.mint.withValues(alpha: 0.85),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
