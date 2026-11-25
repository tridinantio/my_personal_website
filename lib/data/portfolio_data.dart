import 'package:flutter/material.dart';

import '../models/portfolio_models.dart';
import '../theme/app_theme.dart';

class PortfolioData {
  static const fullName = 'Trinanda Dinantio';
  static const monogram = 'TD';
  static const roleTitle = 'Flutter Engineer';
  static const location = 'Tangerang, Indonesia';
  static const email = 'tridinantio@gmail.com';

  static const linkedinUrl = 'https://www.linkedin.com/in/trinanda-dinantio/';
  static const githubUrl = 'https://github.com/tridinantio';

  static const heroSubtitle =
      'Product-minded Flutter Engineer with 4+ years of experience shipping F&B POS systems, hardware & bank ECR integrations, AI business assistants with voice output, and scalable mobile & tablet apps.';

  static const aboutParagraph =
      'I build and maintain production Flutter applications used by real businesses every day—from multi-device F&B Point of Sales and AI-powered business assistants to SME recruitment platforms. My work spans clean feature-first architecture, hardware & payment terminal integrations, large-scale code refactoring, Flutter version migrations, and technical specifications—with cross-stack exposure across Angular, Go, and PHP.';

  static const heroStats = [
    HeroStat(value: '4+ Years', label: 'Flutter & Mobile Engineering'),
    HeroStat(value: '3 Live Apps', label: 'Published on Google Play'),
    HeroStat(value: '5,000+ LOC', label: 'Legacy Code Refactored'),
    HeroStat(value: 'POS & AI', label: 'Printers, ECR & TTS Systems'),
  ];

  static const skillGroups = [
    SkillGroup(
      title: 'Mobile & Web Frameworks',
      icon: Icons.devices_rounded,
      accent: AppColors.mint,
      skills: ['Flutter (Mobile & Tablet)', 'Angular'],
    ),
    SkillGroup(
      title: 'Programming Languages',
      icon: Icons.code_rounded,
      accent: AppColors.sky,
      skills: ['Dart', 'Go', 'PHP', 'Java'],
    ),
    SkillGroup(
      title: 'State & Architecture',
      icon: Icons.account_tree_rounded,
      accent: AppColors.violet,
      skills: ['BLoC', 'Cubit', 'GetX', 'Feature-First Modular'],
    ),
    SkillGroup(
      title: 'Data, Networking & Cloud',
      icon: Icons.storage_rounded,
      accent: AppColors.amber,
      skills: ['RESTful APIs', 'Dio', 'Firebase', 'SQLite'],
    ),
    SkillGroup(
      title: 'POS, Hardware & AI',
      icon: Icons.point_of_sale_rounded,
      accent: AppColors.mint,
      skills: [
        'Bluetooth / USB / Network Printers',
        'Bank ECR Payment Terminals',
        'AI Chatbot UI',
        'Text-to-Speech (TTS)',
      ],
    ),
    SkillGroup(
      title: 'Workflow & Tools',
      icon: Icons.build_circle_outlined,
      accent: AppColors.sky,
      skills: [
        'Git & GitHub',
        'Jira',
        'Figma',
        'VS Code',
        'Claude (AI-Assisted Dev)',
        'Technical Specs',
        'Agile / Scrum',
      ],
    ),
  ];

  static const experiences = [
    ExperienceItemData(
      period: 'Nov 2023 — Present',
      role: 'Flutter Engineer',
      company: 'PT. Esensi Solusi Buana',
      location: 'Tangerang, Indonesia',
      productLinks: [
        ProductLink(
          label: 'ESB POSLite',
          url: 'https://play.google.com/store/apps/details?id=id.co.esb.esb_pos&hl=id',
        ),
        ProductLink(
          label: 'OLIN by ESB',
          url: 'https://play.google.com/store/apps/details?id=id.co.esb.esb_olin&hl=en',
        ),
      ],
      details: [
        'Engineer and maintain two flagship F&B mobile products—ESB POSLite (Point of Sales) and OLIN by ESB (AI business assistant)—across mobile and tablet devices.',
        'Build and maintain mission-critical POS integrations in ESB POSLite, supporting Bluetooth, USB, and Network printer connectivity alongside bank ECR (Electronic Cash Register) payment terminal integrations.',
        'Develop OLIN by ESB features including an interactive AI business-data chatbot with Text-to-Speech (text-to-voice) responses, plus 30+ interactive UI screens and 10+ features from Figma specifications.',
        'Refactored 5,000+ lines of legacy code and led the production migration from Flutter 2.x to Flutter 3.x, while gaining cross-stack exposure across Angular, Go, and PHP.',
        'Author detailed Technical Specification Documents for 7+ features and leverage AI-assisted development workflows (Claude) with GitHub and Jira.',
      ],
      techStack: [
        'Flutter',
        'Dart',
        'Printers & Bank ECR',
        'AI Chatbot & TTS',
        'Angular / Go / PHP',
        'Claude AI',
      ],
    ),
    ExperienceItemData(
      period: 'Jan 2022 — Nov 2022',
      role: 'Product Engineer (Front-End Flutter Developer)',
      company: 'Jobseeker Company',
      location: 'Jakarta, Indonesia',
      productLinks: [
        ProductLink(
          label: 'jobseeker.partners',
          url: 'https://play.google.com/store/apps/details?id=com.jobseeker.partners',
        ),
      ],
      details: [
        'Developed and delivered the jobseeker.partners Flutter recruitment app within a 7-month cycle alongside 5 mobile engineers and 4 cross-functional departments.',
        'Migrated the project structure from a layer-first layout to a feature-first modular architecture, improving codebase readability and team velocity.',
        'Integrated 100+ RESTful API endpoints and third-party packages/plugins while converting Figma design components into reusable mobile UI.',
        'Investigated and resolved 80+ QA and production defects to maintain high application stability across releases.',
      ],
      techStack: [
        'Flutter',
        'Dart',
        'Feature-First Architecture',
        'RESTful APIs',
        'Figma',
      ],
    ),
    ExperienceItemData(
      period: 'Oct 2020 — Jun 2021',
      role: 'Software Engineer (Front-End Flutter, Remote Contract)',
      company: 'Belfarm.ID',
      location: 'Jakarta, Indonesia',
      details: [
        'Designed mobile application user flows, wireframes, and UI layouts in Figma, then implemented the end-to-end Flutter mobile application.',
        'Integrated backend RESTful APIs and third-party plugins, and conducted iterative testing, debugging, and stakeholder reviews throughout the product lifecycle.',
      ],
      techStack: ['Flutter', 'Dart', 'Figma', 'RESTful APIs'],
    ),
  ];

  static const projects = [
    ProjectItemData(
      number: '01',
      name: 'ESB POSLite',
      category: 'Restaurant POS · Mobile & Tablet',
      company: 'PT. Esensi Solusi Buana',
      badgeLabel: 'Hardware & Payment POS',
      summary:
          'Streamlined Point of Sales platform for F&B businesses operating on mobile and tablet devices with real-world hardware and payment terminal reliability.',
      highlights: [
        'Bluetooth, USB, and Network receipt/kitchen printer connectivity',
        'Bank ECR (Electronic Cash Register) payment terminal integrations',
        'Refactored 5,000+ lines of legacy code into cleaner modules',
        'Led production migration from Flutter 2.x to Flutter 3.x',
      ],
      techStack: [
        'Flutter',
        'Dart',
        'SQLite',
        'Dio',
        'Bluetooth / USB / LAN',
        'Bank ECR',
      ],
      accent: AppColors.mint,
      icon: Icons.point_of_sale_rounded,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=id.co.esb.esb_pos&hl=id',
    ),
    ProjectItemData(
      number: '02',
      name: 'OLIN by ESB',
      category: 'AI Business Assistant · F&B',
      company: 'PT. Esensi Solusi Buana',
      badgeLabel: 'AI Chatbot + Voice',
      summary:
          'AI assistant for F&B SME and enterprise owners that answers operational and business-data questions through interactive chat and spoken voice responses.',
      highlights: [
        'Interactive AI chatbot answering real-time F&B business data queries',
        'Text-to-Speech (text-to-voice) playback for hands-free business insights',
        'Delivered 30+ Figma screens & 10+ features across mobile & tablet',
        'Authored detailed Technical Specification Documents for 7+ features',
      ],
      techStack: [
        'Flutter',
        'Dart',
        'AI Chatbot UI',
        'Text-to-Speech',
        'REST APIs',
        'Firebase',
      ],
      accent: AppColors.sky,
      icon: Icons.auto_awesome_rounded,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=id.co.esb.esb_olin&hl=en',
    ),
    ProjectItemData(
      number: '03',
      name: 'jobseeker.partners',
      category: 'Recruitment Platform · SME',
      company: 'Jobseeker Company',
      badgeLabel: 'Feature-First Scale',
      summary:
          'Mobile recruitment platform connecting Indonesian micro and small businesses with candidates through a modern social-first hiring flow.',
      highlights: [
        'Shipped end-to-end Flutter app in 7 months with 5 mobile engineers',
        'Migrated codebase from layer-first to feature-first modular architecture',
        'Integrated 100+ RESTful API endpoints & reusable Figma UI components',
        'Resolved 80+ QA and production bugs to stabilize releases',
      ],
      techStack: [
        'Flutter',
        'Dart',
        'Feature-First',
        'REST APIs',
        'Figma to UI',
      ],
      accent: AppColors.amber,
      icon: Icons.people_alt_rounded,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.jobseeker.partners',
    ),
  ];

  static const education = EducationData(
    university: 'Universiti Utara Malaysia (UUM)',
    location: 'Sintok, Kedah, Malaysia',
    degree:
        'Bachelor of Science (Honours) in Information Technology, Majoring in Software Engineering',
    graduation: 'Graduated Nov 2020',
    cgpa: '3.61 / 4.00',
    honors: "Dean's List Award (4 Semesters: 1st, 5th, 6th & 7th)",
  );

  static const certification = 'UI/UX Gestalt Design — BuildWithAngga';
  static const languages =
      'Bahasa Indonesia (Native) · English (Professional Working Proficiency)';
}
