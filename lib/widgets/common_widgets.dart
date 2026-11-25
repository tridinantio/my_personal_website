import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum ScreenBand { mobile, tablet, desktop }

ScreenBand screenBandFor(double width) {
  if (width >= 960) return ScreenBand.desktop;
  if (width >= 600) return ScreenBand.tablet;
  return ScreenBand.mobile;
}

class SiteShell extends StatelessWidget {
  const SiteShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontal = switch (screenBandFor(constraints.maxWidth)) {
          ScreenBand.desktop => 36.0,
          ScreenBand.tablet => 28.0,
          ScreenBand.mobile => 18.0,
        };
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontal),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class EditorialSectionHeader extends StatelessWidget {
  const EditorialSectionHeader({
    super.key,
    required this.index,
    required this.title,
    this.subtitle,
  });

  final String index;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final palette = EditorialPalette.of(context);
    final band = screenBandFor(MediaQuery.sizeOf(context).width);
    final titleStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontSize: switch (band) {
        ScreenBand.desktop => 36,
        ScreenBand.tablet => 30,
        ScreenBand.mobile => 26,
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              index,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: palette.accent,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Semantics(
                header: true,
                child: Text(title, style: titleStyle),
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 660),
            child: Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
        const SizedBox(height: 18),
        Divider(height: 1, thickness: 1, color: palette.hairline),
      ],
    );
  }
}

class InlineTag extends StatelessWidget {
  const InlineTag(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = EditorialPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: palette.canvas,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: palette.hairline),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
          color: palette.inkMuted,
          height: 1.2,
        ),
      ),
    );
  }
}

class EditorialTextLink extends StatelessWidget {
  const EditorialTextLink({
    super.key,
    required this.label,
    required this.onPressed,
    this.external = false,
    this.emphasize = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool external;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final palette = EditorialPalette.of(context);
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(44, 44)),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        ),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return palette.accent;
          }
          return emphasize ? palette.accent : palette.ink;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return BorderSide(color: palette.accent, width: 2);
          }
          return BorderSide.none;
        }),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: emphasize ? palette.accent : palette.borderStrong,
                decorationThickness: 1.2,
              ),
            ),
          ),
          if (external) ...[
            const SizedBox(width: 5),
            const Icon(Icons.open_in_new, size: 14),
          ],
        ],
      ),
    );
  }
}
