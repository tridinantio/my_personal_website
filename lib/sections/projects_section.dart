import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../models/portfolio_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key, required this.onOpenUri});

  final Future<void> Function(String url) onOpenUri;

  void _showProjectDialog(BuildContext context, ProjectItemData project) {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: project.accent.withValues(alpha: 0.45)),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: project.accent.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(project.icon, color: project.accent),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            '${project.company} · ${project.category}',
                            style: const TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                      color: AppColors.textMuted,
                      tooltip: 'Close',
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  project.summary,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'ENGINEERING HIGHLIGHTS',
                  style: TextStyle(
                    color: project.accent,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.3,
                  ),
                ),
                const SizedBox(height: 10),
                ...project.highlights.map(
                  (highlight) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Icon(
                            Icons.check_circle_outline_rounded,
                            size: 16,
                            color: project.accent,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            highlight,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.techStack
                      .map((t) => TechChip(t, accent: project.accent, compact: true))
                      .toList(),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                    if (project.playStoreUrl != null) ...[
                      const SizedBox(width: 10),
                      FilledButton.icon(
                        onPressed: () => onOpenUri(project.playStoreUrl!),
                        icon: const Icon(Icons.open_in_new_rounded, size: 16),
                        label: const Text('Open on Google Play'),
                        style: FilledButton.styleFrom(
                          backgroundColor: project.accent,
                          foregroundColor: AppColors.ink,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionBlock(
      eyebrow: '03 / SELECTED WORK',
      title: 'Live production apps used by real businesses.',
      subtitle:
          'Every product below is shipped on Google Play—covering multi-device POS hardware & bank ECR terminals, AI voice-enabled analytics, and SME hiring.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 960
              ? 3
              : constraints.maxWidth >= 620
                  ? 2
                  : 1;
          const spacing = 18.0;
          final projects = PortfolioData.projects;

          if (columns == 1) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < projects.length; i++) ...[
                  _ProjectCard(
                    project: projects[i],
                    onOpenUri: onOpenUri,
                    onViewDetails: () =>
                        _showProjectDialog(context, projects[i]),
                    stretchFooter: false,
                  ),
                  if (i < projects.length - 1) const SizedBox(height: spacing),
                ],
              ],
            );
          }

          final rows = <Widget>[];
          for (var i = 0; i < projects.length; i += columns) {
            final rowItems = projects.sublist(
              i,
              i + columns > projects.length ? projects.length : i + columns,
            );
            rows.add(
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var j = 0; j < columns; j++) ...[
                      Expanded(
                        child: j < rowItems.length
                            ? _ProjectCard(
                                project: rowItems[j],
                                onOpenUri: onOpenUri,
                                onViewDetails: () =>
                                    _showProjectDialog(context, rowItems[j]),
                                stretchFooter: true,
                              )
                            : const SizedBox.shrink(),
                      ),
                      if (j < columns - 1) const SizedBox(width: spacing),
                    ],
                  ],
                ),
              ),
            );
            if (i + columns < projects.length) {
              rows.add(const SizedBox(height: spacing));
            }
          }

          return Column(children: rows);
        },
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.onOpenUri,
    required this.onViewDetails,
    required this.stretchFooter,
  });

  final ProjectItemData project;
  final Future<void> Function(String url) onOpenUri;
  final VoidCallback onViewDetails;
  final bool stretchFooter;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      padding: const EdgeInsets.all(22),
      borderRadius: 24,
      hoverBorderColor: project.accent.withValues(alpha: 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  project.accent.withValues(alpha: 0.2),
                  project.accent.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: project.accent.withValues(alpha: 0.22),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.ink.withValues(alpha: 0.72),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: project.accent.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          project.badgeLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: project.accent,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      project.number,
                      style: TextStyle(
                        color: project.accent.withValues(alpha: 0.8),
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.ink.withValues(alpha: 0.78),
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          color: project.accent.withValues(alpha: 0.35),
                        ),
                      ),
                      child: Icon(
                        project.icon,
                        size: 24,
                        color: project.accent,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.text,
                            ),
                          ),
                          Text(
                            project.category,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            project.summary,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 14),
          ...project.highlights.take(2).map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Icon(
                      Icons.bolt_rounded,
                      size: 14,
                      color: project.accent,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.text,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.techStack
                .map((tech) => TechChip(tech, compact: true))
                .toList(),
          ),
          if (stretchFooter) const Spacer(),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: onViewDetails,
                icon: const Icon(Icons.layers_outlined, size: 16),
                label: const Text('Highlights'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.text,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                ),
              ),
              if (project.playStoreUrl != null)
                TextButton.icon(
                  onPressed: () => onOpenUri(project.playStoreUrl!),
                  icon: const Icon(Icons.open_in_new_rounded, size: 16),
                  label: const Text('Google Play'),
                  style: TextButton.styleFrom(
                    foregroundColor: project.accent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
