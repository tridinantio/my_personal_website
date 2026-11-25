import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data/portfolio_data.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/education_section.dart';
import 'sections/experience_section.dart';
import 'sections/hero_section.dart';
import 'sections/nav_bar.dart';
import 'sections/projects_section.dart';
import 'theme/app_theme.dart';
import 'widgets/common_widgets.dart';

void main() => runApp(const PersonalWebsite());

class PersonalWebsite extends StatelessWidget {
  const PersonalWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trinanda Dinantio | Flutter Engineer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();
  final _aboutKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _scrollTo(GlobalKey key) {
    final target = key.currentContext;
    if (target != null) {
      Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeOutCubic,
        alignment: 0.04,
      );
    }
  }

  Future<void> _openUri(String value) async {
    final uri = Uri.parse(value);
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
      webOnlyWindowName: '_blank',
    );
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open link: $value')),
      );
    }
  }

  Future<void> _copyEmail() async {
    await Clipboard.setData(const ClipboardData(text: PortfolioData.email));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Email copied to clipboard: ${PortfolioData.email}'),
          duration: Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 900;
              return Column(
                children: [
                  StickyNavBar(
                    compact: compact,
                    onTop: _scrollToTop,
                    onAbout: () => _scrollTo(_aboutKey),
                    onExperience: () => _scrollTo(_experienceKey),
                    onProjects: () => _scrollTo(_projectsKey),
                    onEducation: () => _scrollTo(_educationKey),
                    onContact: () => _scrollTo(_contactKey),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: SiteShell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            HeroSection(
                              compact: compact,
                              onExploreWork: () => _scrollTo(_projectsKey),
                              onContact: () => _scrollTo(_contactKey),
                              onOpenUri: _openUri,
                              onCopyEmail: _copyEmail,
                            ),
                            AboutSection(key: _aboutKey),
                            ExperienceSection(
                              key: _experienceKey,
                              onOpenUri: _openUri,
                            ),
                            ProjectsSection(
                              key: _projectsKey,
                              onOpenUri: _openUri,
                            ),
                            EducationSection(key: _educationKey),
                            ContactSection(
                              key: _contactKey,
                              onOpenUri: _openUri,
                              onCopyEmail: _copyEmail,
                            ),
                            const PortfolioFooter(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
