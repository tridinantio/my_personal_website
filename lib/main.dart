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
import 'widgets/ai_love_badge.dart';
import 'widgets/common_widgets.dart';

void main() => runApp(const PersonalWebsite());

class PersonalWebsite extends StatefulWidget {
  const PersonalWebsite({super.key});

  @override
  State<PersonalWebsite> createState() => _PersonalWebsiteState();
}

class _PersonalWebsiteState extends State<PersonalWebsite> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trinanda Dinantio | Flutter Engineer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,
      home: PortfolioPage(
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();
  final _workKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _stackKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _contactKey = GlobalKey();

  bool _emailCopied = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Duration _motionDuration(BuildContext context) {
    return MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 420);
  }

  void _scrollToTop() {
    if (!_scrollController.hasClients) return;
    final duration = _motionDuration(context);
    if (duration == Duration.zero) {
      _scrollController.jumpTo(0);
    } else {
      _scrollController.animateTo(
        0,
        duration: duration,
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _scrollTo(GlobalKey key) {
    final target = key.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: _motionDuration(context),
      curve: Curves.easeOutCubic,
      alignment: 0.03,
    );
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
    setState(() => _emailCopied = true);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Copied ${PortfolioData.email} to clipboard.'),
          duration: Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const AiLoveFloatingBadge(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SelectionArea(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final band = screenBandFor(constraints.maxWidth);
              return Column(
                children: [
                  EditorialNavBar(
                    band: band,
                    isDark: widget.isDark,
                    onToggleTheme: widget.onToggleTheme,
                    onTop: _scrollToTop,
                    onWork: () => _scrollTo(_workKey),
                    onExperience: () => _scrollTo(_experienceKey),
                    onStack: () => _scrollTo(_stackKey),
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
                              band: band,
                              emailCopied: _emailCopied,
                              onReadWork: () => _scrollTo(_workKey),
                              onCopyEmail: _copyEmail,
                              onOpenUri: _openUri,
                            ),
                            ProjectsSection(
                              key: _workKey,
                              band: band,
                              onOpenUri: _openUri,
                            ),
                            ExperienceSection(
                              key: _experienceKey,
                              band: band,
                              onOpenUri: _openUri,
                            ),
                            AboutSection(key: _stackKey, band: band),
                            EducationSection(key: _educationKey, band: band),
                            ContactSection(
                              key: _contactKey,
                              band: band,
                              emailCopied: _emailCopied,
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
