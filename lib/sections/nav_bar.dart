import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class EditorialNavBar extends StatelessWidget {
  const EditorialNavBar({
    super.key,
    required this.band,
    required this.isDark,
    required this.onToggleTheme,
    required this.onTop,
    required this.onWork,
    required this.onExperience,
    required this.onStack,
    required this.onEducation,
    required this.onContact,
  });

  final ScreenBand band;
  final bool isDark;
  final VoidCallback onToggleTheme;
  final VoidCallback onTop;
  final VoidCallback onWork;
  final VoidCallback onExperience;
  final VoidCallback onStack;
  final VoidCallback onEducation;
  final VoidCallback onContact;

  void _openMobileMenu(BuildContext context) {
    final palette = EditorialPalette.of(context);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: palette.surfaceCrisp,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        side: BorderSide(color: palette.hairline),
      ),
      builder: (sheetContext) {
        void go(VoidCallback action) {
          Navigator.of(sheetContext).pop();
          action();
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      'Navigate',
                      style: Theme.of(sheetContext).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(sheetContext).pop(),
                      icon: const Icon(Icons.close),
                      tooltip: 'Close menu',
                      constraints: const BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                      ),
                    ),
                  ],
                ),
                Divider(height: 1, color: palette.hairline),
                const SizedBox(height: 8),
                _SheetNavItem(
                  index: '01',
                  label: 'Selected work',
                  onTap: () => go(onWork),
                ),
                _SheetNavItem(
                  index: '02',
                  label: 'Experience',
                  onTap: () => go(onExperience),
                ),
                _SheetNavItem(
                  index: '03',
                  label: 'Technical stack',
                  onTap: () => go(onStack),
                ),
                _SheetNavItem(
                  index: '04',
                  label: 'Education',
                  onTap: () => go(onEducation),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => go(onContact),
                  child: const Text('Contact Trinanda'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = EditorialPalette.of(context);
    final isDesktop = band == ScreenBand.desktop;

    return Container(
      decoration: BoxDecoration(
        color: palette.canvas,
        border: Border(bottom: BorderSide(color: palette.hairline)),
      ),
      child: SiteShell(
        child: SizedBox(
          height: isDesktop ? 68 : 60,
          child: Row(
            children: [
              Flexible(
                flex: isDesktop ? 0 : 1,
                fit: isDesktop ? FlexFit.loose : FlexFit.tight,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: onTop,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 8,
                      ),
                      minimumSize: const Size(44, 44),
                    ),
                    child: Text(
                      PortfolioData.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTheme.displayFont,
                        fontSize: isDesktop ? 20 : 17.5,
                        fontWeight: FontWeight.w600,
                        color: palette.ink,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                ),
              ),
              if (isDesktop) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(onPressed: onWork, child: const Text('Work')),
                          TextButton(
                            onPressed: onExperience,
                            child: const Text('Experience'),
                          ),
                          TextButton(
                            onPressed: onStack,
                            child: const Text('Stack'),
                          ),
                          TextButton(
                            onPressed: onEducation,
                            child: const Text('Education'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _ThemeToggleButton(
                  isDark: isDark,
                  onToggle: onToggleTheme,
                  iconOnly: false,
                ),
                const SizedBox(width: 10),
                FilledButton(
                  onPressed: onContact,
                  child: const Text('Get in touch'),
                ),
              ] else ...[
                const SizedBox(width: 8),
                _ThemeToggleButton(
                  isDark: isDark,
                  onToggle: onToggleTheme,
                  iconOnly: band == ScreenBand.mobile,
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () => _openMobileMenu(context),
                  icon: const Icon(Icons.menu, size: 18),
                  label: const Text('Menu'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(44, 44),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  const _ThemeToggleButton({
    required this.isDark,
    required this.onToggle,
    required this.iconOnly,
  });

  final bool isDark;
  final VoidCallback onToggle;
  final bool iconOnly;

  @override
  Widget build(BuildContext context) {
    final label = isDark ? 'Light' : 'Dark';
    final tooltipText =
        isDark ? 'Switch to light theme' : 'Switch to dark theme';
    final icon = isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined;

    if (iconOnly) {
      return OutlinedButton(
        onPressed: onToggle,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(44, 44),
          padding: EdgeInsets.zero,
        ),
        child: Tooltip(
          message: tooltipText,
          child: Semantics(
            label: tooltipText,
            child: Icon(icon, size: 18),
          ),
        ),
      );
    }

    return Tooltip(
      message: tooltipText,
      child: OutlinedButton.icon(
        onPressed: onToggle,
        icon: Icon(icon, size: 16),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(44, 44),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }
}

class _SheetNavItem extends StatelessWidget {
  const _SheetNavItem({
    required this.index,
    required this.label,
    required this.onTap,
  });

  final String index;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = EditorialPalette.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
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
              const SizedBox(width: 14),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: palette.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
