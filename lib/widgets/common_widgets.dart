import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SiteShell extends StatelessWidget {
  const SiteShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: child,
        ),
      ),
    );
  }
}

class SectionBlock extends StatelessWidget {
  const SectionBlock({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    required this.child,
    this.verticalPadding = 64,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;
  final Widget child;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EyebrowLabel(text: eyebrow),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 740),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
          const SizedBox(height: 32),
          child,
        ],
      ),
    );
  }
}

class EyebrowLabel extends StatelessWidget {
  const EyebrowLabel({
    super.key,
    required this.text,
    this.dark = false,
  });

  final String text;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: dark ? AppColors.ink : AppColors.mint,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.4,
      ),
    );
  }
}

class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 22,
    this.hoverBorderColor = AppColors.borderHover,
    this.backgroundColor = AppColors.surface,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color hoverBorderColor;
  final Color backgroundColor;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: _hovered
              ? Color.alphaBlend(
                  widget.hoverBorderColor.withValues(alpha: 0.05),
                  widget.backgroundColor,
                )
              : widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: _hovered ? widget.hoverBorderColor : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.28),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ]
              : const [],
        ),
        child: widget.child,
      ),
    );
  }
}

class TechChip extends StatelessWidget {
  const TechChip(
    this.label, {
    super.key,
    this.accent,
    this.compact = false,
  });

  final String label;
  final Color? accent;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final borderColor = accent != null
        ? accent!.withValues(alpha: 0.28)
        : AppColors.border;
    final bgColor = accent != null
        ? accent!.withValues(alpha: 0.08)
        : AppColors.inkSoft;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 10 : 12,
        vertical: compact ? 5 : 7,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: compact ? 12 : 13,
          fontWeight: FontWeight.w500,
          color: accent ?? AppColors.text,
          height: 1.1,
        ),
      ),
    );
  }
}

class SocialActionPill extends StatelessWidget {
  const SocialActionPill({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.dark = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: dark ? AppColors.ink : AppColors.text,
        backgroundColor: dark
            ? AppColors.ink.withValues(alpha: 0.08)
            : AppColors.surface.withValues(alpha: 0.7),
        side: BorderSide(
          color: dark
              ? AppColors.ink.withValues(alpha: 0.25)
              : AppColors.border,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
      ),
    );
  }
}
