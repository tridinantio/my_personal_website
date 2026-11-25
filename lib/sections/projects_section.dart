import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../models/portfolio_models.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({
    super.key,
    required this.band,
    required this.onOpenUri,
  });

  final ScreenBand band;
  final Future<void> Function(String url) onOpenUri;

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  WorkDomain _selectedDomain = WorkDomain.all;

  List<WorkProject> get _filteredProjects {
    if (_selectedDomain == WorkDomain.all) {
      return PortfolioData.projects;
    }
    return PortfolioData.projects
        .where((project) => project.domain == _selectedDomain)
        .toList();
  }

  void _openNotesDialog(BuildContext context, WorkProject project) {
    final palette = EditorialPalette.of(context);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: palette.surfaceCrisp,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: palette.borderStrong),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(26),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${project.index} / ${project.company}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: palette.accent,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            project.name,
                            style: Theme.of(dialogContext).textTheme.headlineMedium
                                ?.copyWith(fontSize: 28),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${project.category} (${project.period})',
                            style: Theme.of(dialogContext).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      icon: const Icon(Icons.close),
                      tooltip: 'Close technical notes',
                      constraints: const BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(height: 1, color: palette.hairline),
                const SizedBox(height: 16),
                Text(
                  project.summary,
                  style: TextStyle(
                    fontSize: 15,
                    color: palette.ink,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Engineering contributions',
                  style: Theme.of(dialogContext).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                for (final note in project.engineeringNotes)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '- ',
                          style: TextStyle(
                            color: palette.accent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            note,
                            style: Theme.of(dialogContext).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.stack.map(InlineTag.new).toList(),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: const Text('Close'),
                    ),
                    FilledButton.icon(
                      onPressed: () => widget.onOpenUri(project.playStoreUrl),
                      icon: const Icon(Icons.open_in_new, size: 16),
                      label: const Text('Open on Google Play'),
                    ),
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
    final palette = EditorialPalette.of(context);
    final projects = _filteredProjects;
    final verticalPad = switch (widget.band) {
      ScreenBand.desktop => 64.0,
      ScreenBand.tablet => 48.0,
      ScreenBand.mobile => 36.0,
    };

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EditorialSectionHeader(
            index: '01',
            title: 'Selected work',
            subtitle:
                'Production Android and tablet applications shipped on Google Play.',
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: WorkDomain.values.map((domain) {
              final active = _selectedDomain == domain;
              final label = PortfolioData.domainLabels[domain]!;
              return OutlinedButton(
                onPressed: () => setState(() => _selectedDomain = domain),
                style: ButtonStyle(
                  minimumSize: const WidgetStatePropertyAll(Size(44, 44)),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    active ? palette.ink : Colors.transparent,
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    active ? palette.canvas : palette.ink,
                  ),
                  side: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.focused)) {
                      return BorderSide(color: palette.accent, width: 2);
                    }
                    return BorderSide(
                      color: active ? palette.ink : palette.borderStrong,
                    );
                  }),
                ),
                child: Text(label),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          if (projects.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: palette.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: palette.hairline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No projects match this filter.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () =>
                        setState(() => _selectedDomain = WorkDomain.all),
                    child: const Text('Show all work'),
                  ),
                ],
              ),
            )
          else if (_selectedDomain == WorkDomain.all && projects.length == 3) ...[
            _PrimaryCaseStudy(
              project: projects[0],
              band: widget.band,
              onOpenUri: widget.onOpenUri,
              onReadNotes: () => _openNotesDialog(context, projects[0]),
            ),
            const SizedBox(height: 24),
            _SecondaryWorkPair(
              first: projects[1],
              second: projects[2],
              band: widget.band,
              onOpenUri: widget.onOpenUri,
              onReadNotes: (p) => _openNotesDialog(context, p),
            ),
          ] else ...[
            for (var i = 0; i < projects.length; i++) ...[
              _PrimaryCaseStudy(
                project: projects[i],
                band: widget.band,
                onOpenUri: widget.onOpenUri,
                onReadNotes: () => _openNotesDialog(context, projects[i]),
              ),
              if (i < projects.length - 1) const SizedBox(height: 20),
            ],
          ],
        ],
      ),
    );
  }
}

class _PrimaryCaseStudy extends StatelessWidget {
  const _PrimaryCaseStudy({
    required this.project,
    required this.band,
    required this.onOpenUri,
    required this.onReadNotes,
  });

  final WorkProject project;
  final ScreenBand band;
  final Future<void> Function(String url) onOpenUri;
  final VoidCallback onReadNotes;

  @override
  Widget build(BuildContext context) {
    final palette = EditorialPalette.of(context);
    final isWide = band == ScreenBand.desktop;

    final narrative = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${project.index}  ·  ${project.company}  ·  ${project.period}',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: palette.accent,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          project.name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: band == ScreenBand.mobile ? 26 : 32,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          project.category,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: palette.ink,
          ),
        ),
        const SizedBox(height: 14),
        Text(project.summary, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        for (final note in project.engineeringNotes.take(2))
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- ',
                  style: TextStyle(
                    color: palette.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Text(
                    note,
                    style: TextStyle(
                      fontSize: 14.5,
                      color: palette.ink,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.stack.map(InlineTag.new).toList(),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            FilledButton.icon(
              onPressed: () => onOpenUri(project.playStoreUrl),
              icon: const Icon(Icons.open_in_new, size: 16),
              label: const Text('Open on Google Play'),
            ),
            OutlinedButton(
              onPressed: onReadNotes,
              child: const Text('Technical notes'),
            ),
          ],
        ),
      ],
    );

    final specLedger = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: palette.surfaceCrisp,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: palette.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Scope & integrations',
            style: TextStyle(
              fontFamily: AppTheme.displayFont,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: palette.ink,
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < project.architectureSpecs.length; i++) ...[
            if (i > 0) Divider(height: 18, color: palette.hairline),
            Text(
              project.architectureSpecs[i].label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: palette.inkMuted,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              project.architectureSpecs[i].value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: palette.ink,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.all(band == ScreenBand.mobile ? 20 : 28),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.hairline),
      ),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 7, child: narrative),
                const SizedBox(width: 32),
                Expanded(flex: 4, child: specLedger),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                narrative,
                const SizedBox(height: 22),
                specLedger,
              ],
            ),
    );
  }
}

class _SecondaryWorkPair extends StatelessWidget {
  const _SecondaryWorkPair({
    required this.first,
    required this.second,
    required this.band,
    required this.onOpenUri,
    required this.onReadNotes,
  });

  final WorkProject first;
  final WorkProject second;
  final ScreenBand band;
  final Future<void> Function(String url) onOpenUri;
  final void Function(WorkProject project) onReadNotes;

  @override
  Widget build(BuildContext context) {
    if (band == ScreenBand.mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SecondaryWorkCard(
            project: first,
            stretchFooter: false,
            onOpenUri: onOpenUri,
            onReadNotes: () => onReadNotes(first),
          ),
          const SizedBox(height: 18),
          _SecondaryWorkCard(
            project: second,
            stretchFooter: false,
            onOpenUri: onOpenUri,
            onReadNotes: () => onReadNotes(second),
          ),
        ],
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _SecondaryWorkCard(
              project: first,
              stretchFooter: true,
              onOpenUri: onOpenUri,
              onReadNotes: () => onReadNotes(first),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _SecondaryWorkCard(
              project: second,
              stretchFooter: true,
              onOpenUri: onOpenUri,
              onReadNotes: () => onReadNotes(second),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondaryWorkCard extends StatelessWidget {
  const _SecondaryWorkCard({
    required this.project,
    required this.stretchFooter,
    required this.onOpenUri,
    required this.onReadNotes,
  });

  final WorkProject project;
  final bool stretchFooter;
  final Future<void> Function(String url) onOpenUri;
  final VoidCallback onReadNotes;

  @override
  Widget build(BuildContext context) {
    final palette = EditorialPalette.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: palette.canvas,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${project.index}  ·  ${project.company}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: palette.accent,
            ),
          ),
          const SizedBox(height: 8),
          Text(project.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 3),
          Text(
            project.category,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: palette.ink,
            ),
          ),
          const SizedBox(height: 12),
          Text(project.summary, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 14),
          for (final note in project.engineeringNotes.take(2))
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '- ',
                    style: TextStyle(
                      color: palette.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      note,
                      style: TextStyle(
                        fontSize: 14,
                        color: palette.ink,
                        height: 1.48,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.stack.map(InlineTag.new).toList(),
          ),
          if (stretchFooter) const Spacer(),
          const SizedBox(height: 18),
          Divider(height: 1, color: palette.hairline),
          const SizedBox(height: 10),
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              EditorialTextLink(
                label: 'Technical notes',
                onPressed: onReadNotes,
              ),
              EditorialTextLink(
                label: 'Google Play',
                external: true,
                emphasize: true,
                onPressed: () => onOpenUri(project.playStoreUrl),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
