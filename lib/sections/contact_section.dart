import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    required this.band,
    required this.emailCopied,
    required this.onOpenUri,
    required this.onCopyEmail,
  });

  final ScreenBand band;
  final bool emailCopied;
  final Future<void> Function(String url) onOpenUri;
  final VoidCallback onCopyEmail;

  @override
  Widget build(BuildContext context) {
    final palette = EditorialPalette.of(context);
    final pad = switch (band) {
      ScreenBand.desktop => 40.0,
      ScreenBand.tablet => 30.0,
      ScreenBand.mobile => 22.0,
    };

    final invertedOutlinedStyle = ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(44, 46)),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      foregroundColor: WidgetStatePropertyAll(palette.invertedInk),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return palette.invertedInk.withValues(alpha: 0.08);
        }
        return Colors.transparent;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: palette.accent, width: 2);
        }
        return BorderSide(color: palette.invertedBorder);
      }),
    );

    return Container(
      margin: EdgeInsets.only(
        top: band == ScreenBand.mobile ? 28 : 48,
        bottom: 28,
      ),
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: palette.invertedBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.invertedBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: palette.accent,
            ),
          ),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Semantics(
              header: true,
              child: Text(
                'Looking for a Flutter engineer?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: palette.invertedInk,
                  fontSize: band == ScreenBand.mobile ? 28 : 36,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              'I am open to Mid and Senior Flutter Engineer roles (onsite, hybrid, or remote). Send an email or message me on LinkedIn, and I will share my full resume on request.',
              style: TextStyle(
                color: palette.invertedMuted,
                fontSize: 15.5,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () => onOpenUri('mailto:${PortfolioData.email}'),
                icon: const Icon(Icons.mail_outline, size: 17),
                label: const Text('Email ${PortfolioData.email}'),
              ),
              OutlinedButton.icon(
                onPressed: onCopyEmail,
                style: invertedOutlinedStyle,
                icon: Icon(
                  emailCopied ? Icons.check : Icons.content_copy,
                  size: 16,
                ),
                label: Text(emailCopied ? 'Copied' : 'Copy email'),
              ),
              OutlinedButton.icon(
                onPressed: () => onOpenUri(PortfolioData.linkedinUrl),
                style: invertedOutlinedStyle,
                icon: const Icon(Icons.open_in_new, size: 15),
                label: const Text('LinkedIn'),
              ),
              OutlinedButton.icon(
                onPressed: () => onOpenUri(PortfolioData.githubUrl),
                style: invertedOutlinedStyle,
                icon: const Icon(Icons.open_in_new, size: 15),
                label: const Text('GitHub'),
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
    final palette = EditorialPalette.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 88),
      child: Column(
        children: [
          Divider(height: 1, color: palette.hairline),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 16,
              runSpacing: 8,
              children: [
                Text(
                  '${PortfolioData.fullName}, ${PortfolioData.location}',
                  style: TextStyle(color: palette.inkMuted, fontSize: 13.5),
                ),
                Text(
                  'Built with Flutter Web',
                  style: TextStyle(color: palette.inkMuted, fontSize: 13.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
