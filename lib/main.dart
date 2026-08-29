import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const PersonalWebsite());

class PersonalWebsite extends StatelessWidget {
  const PersonalWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trinanda Dinantio | Flutter Engineer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.ink,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.mint,
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 62,
            fontWeight: FontWeight.w800,
            height: 1,
            letterSpacing: -2.6,
          ),
          headlineMedium: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w700,
            height: 1.1,
            letterSpacing: -1.1,
          ),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          bodyLarge: TextStyle(fontSize: 18, height: 1.55),
          bodyMedium: TextStyle(fontSize: 15, height: 1.55),
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

class AppColors {
  static const ink = Color(0xFF0B1220);
  static const surface = Color(0xFF111B2E);
  static const mint = Color(0xFF6EE7B7);
  static const sky = Color(0xFF7DD3FC);
  static const text = Color(0xFFF8FAFC);
  static const textMuted = Color(0xFFB7C3D6);
  static const border = Color(0xFF2B3A54);
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _aboutKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final target = key.currentContext;
    if (target != null) {
      Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeOutCubic,
        alignment: 0.06,
      );
    }
  }

  Future<void> _openUri(String value) =>
      launchUrl(Uri.parse(value), mode: LaunchMode.externalApplication);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 900;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _SiteShell(
                    child: Column(
                      children: [
                        _NavigationBar(
                          compact: compact,
                          onAbout: () => _scrollTo(_aboutKey),
                          onExperience: () => _scrollTo(_experienceKey),
                          onProjects: () => _scrollTo(_projectsKey),
                          onContact: () => _scrollTo(_contactKey),
                        ),
                        _Hero(
                          compact: compact,
                          onProjects: () => _scrollTo(_projectsKey),
                          onContact: () => _scrollTo(_contactKey),
                        ),
                        _AboutSection(key: _aboutKey),
                        _ExperienceSection(key: _experienceKey),
                        _ProjectsSection(
                          key: _projectsKey,
                          compact: compact,
                          onOpenUri: _openUri,
                        ),
                        _ContactSection(key: _contactKey, onOpenUri: _openUri),
                        const _Footer(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SiteShell extends StatelessWidget {
  const _SiteShell({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1240),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: child,
      ),
    ),
  );
}

class _NavigationBar extends StatelessWidget {
  const _NavigationBar({
    required this.compact,
    required this.onAbout,
    required this.onExperience,
    required this.onProjects,
    required this.onContact,
  });

  final bool compact;
  final VoidCallback onAbout;
  final VoidCallback onExperience;
  final VoidCallback onProjects;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 18),
    child: Row(
      children: [
        compact ? const _Monogram() : const _BrandMark(),
        const Spacer(),
        if (!compact) ...[
          _NavItem(label: 'About', onTap: onAbout),
          _NavItem(label: 'Experience', onTap: onExperience),
          _NavItem(label: 'Projects', onTap: onProjects),
          const SizedBox(width: 18),
        ],
        FilledButton(
          onPressed: onContact,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.mint,
            foregroundColor: AppColors.ink,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ),
          child: const Text("Let's talk"),
        ),
      ],
    ),
  );
}

class _Monogram extends StatelessWidget {
  const _Monogram();

  @override
  Widget build(BuildContext context) => Container(
    width: 42,
    height: 42,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppColors.border),
    ),
    child: const Text(
      'TD',
      style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.mint),
    ),
  );
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) => const Row(
    children: [
      _Monogram(),
      SizedBox(width: 10),
      Text(
        'TRINANDA DINANTIO',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.1,
        ),
      ),
    ],
  );
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: onTap,
    style: TextButton.styleFrom(foregroundColor: AppColors.textMuted),
    child: Text(label),
  );
}

class _Hero extends StatelessWidget {
  const _Hero({
    required this.compact,
    required this.onProjects,
    required this.onContact,
  });
  final bool compact;
  final VoidCallback onProjects;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final heading = Theme.of(context).textTheme.displayLarge!;
    return Padding(
      padding: EdgeInsets.only(
        top: compact ? 68 : 108,
        bottom: compact ? 72 : 118,
      ),
      child: Stack(
        children: [
          const Positioned(right: 12, top: 8, child: _HeroOrb()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Eyebrow(text: 'FLUTTER ENGINEER · TANGERANG, INDONESIA'),
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 850),
                child: RichText(
                  text: TextSpan(
                    style: heading.copyWith(fontSize: compact ? 46 : 62),
                    children: const [
                      TextSpan(text: 'Building mobile products that feel '),
                      TextSpan(
                        text: 'simple\nto use.',
                        style: TextStyle(color: AppColors.mint),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 650),
                child: Text(
                  'I turn product requirements and design systems into reliable Flutter experiences for mobile and tablet users.',
                  style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(color: AppColors.textMuted),
                ),
              ),
              const SizedBox(height: 34),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: onProjects,
                    icon: const Icon(Icons.arrow_downward_rounded),
                    label: const Text('Explore my work'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.mint,
                      foregroundColor: AppColors.ink,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 17,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: onContact,
                    icon: const Icon(Icons.mail_outline_rounded),
                    label: const Text('Contact me'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.text,
                      side: const BorderSide(color: AppColors.border),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroOrb extends StatelessWidget {
  const _HeroOrb();

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [Color(0x336EE7B7), Color(0x007DD3FC)],
        ),
        border: Border.all(color: const Color(0x226EE7B7)),
      ),
    ),
  );
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({super.key});

  @override
  Widget build(BuildContext context) => _Section(
    eyebrow: '01 / ABOUT',
    title: 'A product-minded Flutter engineer.',
    child: LayoutBuilder(
      builder: (context, constraints) {
        final overview = Text(
          'I have experience delivering POS, F&B, recruitment, and travel mobile applications. My work spans UI implementation, API integration, debugging, refactoring, Flutter upgrades, and technical specifications.',
          style: Theme.of(context).textTheme.bodyLarge!
              .copyWith(color: AppColors.textMuted),
        );
        const skills = Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _SkillChip('Flutter'),
            _SkillChip('Dart'),
            _SkillChip('REST APIs'),
            _SkillChip('BLoC'),
            _SkillChip('Feature-first architecture'),
            _SkillChip('Figma to UI'),
            _SkillChip('GitHub'),
            _SkillChip('Jira'),
          ],
        );
        if (constraints.maxWidth < 760) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [overview, const SizedBox(height: 28), skills],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 6, child: overview),
            const SizedBox(width: 62),
            const Expanded(flex: 5, child: skills),
          ],
        );
      },
    ),
  );
}

class _SkillChip extends StatelessWidget {
  const _SkillChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: AppColors.border),
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 13, color: AppColors.text),
    ),
  );
}

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) => _Section(
    eyebrow: '02 / EXPERIENCE',
    title: 'Shipped across product, platform, and team boundaries.',
    child: const Column(
      children: [
        _ExperienceItem(
          period: '2023 — Present',
          role: 'Flutter Engineer',
          company: 'PT. Esensi Solusi Buana',
          details: [
            'Developing ESB POSLite and OLIN for F&B business use cases.',
            'Implemented 30+ mobile and tablet screens from design specifications and user flows.',
            'Delivered 10+ features and refactored 5,000+ lines of legacy code.',
            'Upgraded the application from Flutter 2 to Flutter 3.',
          ],
        ),
        _ExperienceItem(
          period: '2022 — 2023',
          role: 'Product Engineer — Front-End Flutter Developer',
          company: 'Jobseeker Company',
          details: [
            'Built Flutter interfaces from Figma designs for a mobile recruitment product.',
            'Troubleshot 80+ bugs and integrated 100+ API endpoints and 78 plugins.',
            'Moved the project from layer-first to feature-first architecture.',
          ],
        ),
        _ExperienceItem(
          period: '2020 — 2021',
          role: 'Software Engineer — Front-End Flutter Developer',
          company: 'Belfarm.ID',
          details: [
            'Designed user flows and wireframes, then developed and tested a Flutter mobile application.',
            'Worked with stakeholders, APIs, and plugins across the product lifecycle.',
          ],
        ),
      ],
    ),
  );
}

class _ExperienceItem extends StatelessWidget {
  const _ExperienceItem({
    required this.period,
    required this.role,
    required this.company,
    required this.details,
  });
  final String period;
  final String role;
  final String company;
  final List<String> details;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: AppColors.border),
    ),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final meta = Text(
          period,
          style: const TextStyle(
            color: AppColors.mint,
            fontWeight: FontWeight.w700,
          ),
        );
        final content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(role, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              company,
              style: const TextStyle(
                color: AppColors.sky,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 14),
            ...details.map(
              (detail) => Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Icon(Icons.circle, size: 6, color: AppColors.mint),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        detail,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
        if (constraints.maxWidth < 720) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [meta, const SizedBox(height: 16), content],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 168, child: meta),
            Expanded(child: content),
          ],
        );
      },
    ),
  );
}

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({
    super.key,
    required this.compact,
    required this.onOpenUri,
  });
  final bool compact;
  final Future<void> Function(String value) onOpenUri;

  @override
  Widget build(BuildContext context) {
    const projects = [
      _Project(
        number: '01',
        name: 'ESB POSLite',
        type: 'Restaurant POS · Flutter',
        description: 'A streamlined POS for F&B businesses. Contributed to UI delivery, feature work, refactoring, technical specs, and the Flutter 2–3 migration.',
        accent: AppColors.mint,
        icon: Icons.point_of_sale_rounded,
        link: 'https://play.google.com/store/apps/details?id=id.co.esb.esb_pos&hl=id',
      ),
      _Project(
        number: '02',
        name: 'OLIN by ESB',
        type: 'AI assistant for F&B · Flutter',
        description: 'An AI assistant for F&B entrepreneurs, offering practical advice for SME and enterprise teams.',
        accent: AppColors.sky,
        icon: Icons.auto_awesome_rounded,
        link: 'https://play.google.com/store/apps/details?id=id.co.esb.esb_olin&hl=en',
      ),
      _Project(
        number: '03',
        name: 'jobseeker.partners',
        type: 'Recruitment platform · Flutter',
        description: 'A recruitment platform helping Indonesian micro and small businesses find suitable candidates.',
        accent: Color(0xFFFBBF77),
        icon: Icons.people_alt_outlined,
        link: 'https://play.google.com/store/apps/details?id=com.jobseeker.partners',
      ),
    ];
    return _Section(
      eyebrow: '03 / SELECTED WORK',
      title: 'Products built for people doing real work.',
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: compact ? 1 : 3,
          mainAxisSpacing: 18,
          crossAxisSpacing: 18,
          mainAxisExtent: compact ? 448 : 420,
        ),
        itemCount: projects.length,
        itemBuilder: (context, index) =>
            _ProjectCard(project: projects[index], onOpenUri: onOpenUri),
      ),
    );
  }
}

class _Project {
  const _Project({
    required this.number,
    required this.name,
    required this.type,
    required this.description,
    required this.accent,
    required this.icon,
    this.link,
  });
  final String number;
  final String name;
  final String type;
  final String description;
  final Color accent;
  final IconData icon;
  final String? link;
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project, required this.onOpenUri});
  final _Project project;
  final Future<void> Function(String value) onOpenUri;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: AppColors.border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 145,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: project.accent.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(project.icon, size: 42, color: project.accent),
        ),
        const SizedBox(height: 18),
        Text(
          project.number,
          style: TextStyle(color: project.accent, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(project.name, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 5),
        Text(
          project.type,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Text(
            project.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.textMuted, height: 1.45),
          ),
        ),
        if (project.link != null)
          TextButton.icon(
            onPressed: () => onOpenUri(project.link!),
            icon: const Icon(Icons.open_in_new_rounded, size: 16),
            label: const Text('View on Google Play'),
            style: TextButton.styleFrom(
              foregroundColor: project.accent,
              padding: EdgeInsets.zero,
            ),
          ),
      ],
    ),
  );
}

class _ContactSection extends StatelessWidget {
  const _ContactSection({super.key, required this.onOpenUri});
  final Future<void> Function(String value) onOpenUri;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(top: 88, bottom: 38),
    padding: const EdgeInsets.all(32),
    decoration: BoxDecoration(
      color: AppColors.mint,
      borderRadius: BorderRadius.circular(28),
    ),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Eyebrow(text: 'OPEN TO FLUTTER OPPORTUNITIES', dark: true),
            const SizedBox(height: 12),
            Text(
              "Let's build a great mobile experience.",
              style: Theme.of(context).textTheme.headlineMedium!
                  .copyWith(color: AppColors.ink),
            ),
          ],
        );
        final action = FilledButton.icon(
          onPressed: () => onOpenUri('mailto:tridinantio@gmail.com'),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.ink,
            foregroundColor: AppColors.text,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
          ),
          icon: const Icon(Icons.mail_outline_rounded),
          label: const Text('tridinantio@gmail.com'),
        );
        if (constraints.maxWidth < 620) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [content, const SizedBox(height: 24), action],
          );
        }
        return Row(
          children: [
            Expanded(child: content),
            action,
          ],
        );
      },
    ),
  );
}

class _Footer extends StatelessWidget {
  const _Footer();
  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.only(bottom: 30),
    child: Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 20,
      runSpacing: 6,
      children: [
        Text(
          '© 2026 Trinanda Dinantio',
          style: TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
        Text(
          'Flutter Engineer',
          style: TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
      ],
    ),
  );
}

class _Section extends StatelessWidget {
  const _Section({
    required this.eyebrow,
    required this.title,
    required this.child,
  });
  final String eyebrow;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 64),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Eyebrow(text: eyebrow),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
        ),
        const SizedBox(height: 32),
        child,
      ],
    ),
  );
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow({required this.text, this.dark = false});
  final String text;
  final bool dark;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      color: dark ? AppColors.ink : AppColors.mint,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.4,
    ),
  );
}
