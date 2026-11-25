import '../models/portfolio_models.dart';

class PortfolioData {
  static const fullName = 'Trinanda Dinantio';
  static const roleTitle = 'Flutter Engineer';
  static const location = 'Tangerang, Indonesia';
  static const email = 'tridinantio@gmail.com';
  static const linkedinUrl = 'https://www.linkedin.com/in/trinanda-dinantio/';
  static const githubUrl = 'https://github.com/tridinantio';

  static const heroHeadline =
      'Flutter engineer building POS terminals, voice AI tools, and mobile apps.';

  static const heroLead =
      'I build and maintain production Flutter software for phones and tablets at PT. Esensi Solusi Buana, working on ESB POSLite and OLIN by ESB. Over the past four years, I have shipped point-of-sale hardware integrations, bank ECR connections, chatbot voice interfaces, and modular app refactors.';

  static const heroLedger = [
    FactRow(
      label: 'Current role',
      value: 'Flutter Engineer, PT. Esensi Solusi Buana',
    ),
    FactRow(label: 'Experience', value: '4+ years in production mobile apps'),
    FactRow(label: 'Based in', value: 'Tangerang, Indonesia'),
    FactRow(
      label: 'Published apps',
      value: 'ESB POSLite, OLIN by ESB, jobseeker.partners',
    ),
  ];

  static const domainLabels = <WorkDomain, String>{
    WorkDomain.all: 'All work (3)',
    WorkDomain.posHardware: 'POS & hardware',
    WorkDomain.aiVoice: 'AI & voice',
    WorkDomain.recruitment: 'Recruitment',
  };

  static const projects = [
    WorkProject(
      index: '01',
      name: 'ESB POSLite',
      category: 'Restaurant point of sale for mobile and tablet',
      company: 'PT. Esensi Solusi Buana',
      period: 'Nov 2023 to Present',
      domain: WorkDomain.posHardware,
      isPrimary: true,
      summary:
          'Point-of-sale software for F&B outlets running on Android phones and tablets. I maintain core cashier flows, hardware connections, and codebase stability for daily store operations.',
      engineeringNotes: [
        'Built and maintained receipt and kitchen printer connectivity over Bluetooth, USB, and local network.',
        'Integrated bank ECR (Electronic Cash Register) payment terminals into checkout flows.',
        'Refactored over 5,000 lines of legacy Dart code to reduce duplication and improve readability.',
        'Upgraded the production codebase from Flutter 2.x to Flutter 3.x, resolving dependency and SDK compatibility issues.',
      ],
      architectureSpecs: [
        FactRow(label: 'Devices', value: 'Android mobile and tablet'),
        FactRow(label: 'Printers', value: 'Bluetooth, USB, Network (LAN)'),
        FactRow(label: 'Payments', value: 'Bank ECR terminal integrations'),
        FactRow(label: 'Codebase', value: 'Flutter 2 to 3 migration, 5,000+ LOC refactor'),
      ],
      stack: ['Flutter', 'Dart', 'SQLite', 'Dio', 'Bluetooth / USB / LAN', 'Bank ECR'],
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=id.co.esb.esb_pos&hl=id',
    ),
    WorkProject(
      index: '02',
      name: 'OLIN by ESB',
      category: 'AI business assistant for F&B operators',
      company: 'PT. Esensi Solusi Buana',
      period: 'Nov 2023 to Present',
      domain: WorkDomain.aiVoice,
      summary:
          'Mobile assistant for SME and enterprise F&B owners to query store and business data through a conversational chat interface with spoken audio replies.',
      engineeringNotes: [
        'Implemented interactive AI chatbot screens that answer operational and business-data questions.',
        'Integrated Text-to-Speech (text-to-voice) playback so users can listen to business answers directly in the app.',
        'Converted 30+ Figma screens into responsive mobile and tablet UI and delivered 10+ new features.',
        'Authored detailed Technical Specification Documents for 7+ features before sprint execution.',
      ],
      architectureSpecs: [
        FactRow(label: 'Core interface', value: 'AI business-data chatbot'),
        FactRow(label: 'Audio output', value: 'Text-to-Speech (text-to-voice)'),
        FactRow(label: 'UI delivery', value: '30+ Figma screens, 10+ features'),
        FactRow(label: 'Documentation', value: '7+ Technical Specification Docs'),
      ],
      stack: ['Flutter', 'Dart', 'AI Chatbot UI', 'Text-to-Speech', 'REST APIs', 'Firebase'],
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=id.co.esb.esb_olin&hl=en',
    ),
    WorkProject(
      index: '03',
      name: 'jobseeker.partners',
      category: 'SME hiring and recruitment app',
      company: 'Jobseeker Company',
      period: 'Jan 2022 to Nov 2022',
      domain: WorkDomain.recruitment,
      summary:
          'Mobile recruitment product helping micro and small businesses across Indonesia review and hire candidates through a social-style workflow.',
      engineeringNotes: [
        'Shipped the Flutter application in 7 months with 5 mobile engineers across 4 departments.',
        'Migrated the repository from a layer-first layout to a feature-first modular architecture.',
        'Integrated 100+ RESTful API endpoints and third-party packages alongside reusable Figma UI components.',
        'Investigated and fixed 80+ QA and production defects across release cycles.',
      ],
      architectureSpecs: [
        FactRow(label: 'Team', value: '5 mobile engineers, 4 departments'),
        FactRow(label: 'Architecture', value: 'Layer-first to feature-first migration'),
        FactRow(label: 'Integrations', value: '100+ REST API endpoints'),
        FactRow(label: 'Stability', value: '80+ bugs diagnosed and fixed'),
      ],
      stack: ['Flutter', 'Dart', 'Feature-First Architecture', 'REST APIs', 'Figma'],
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.jobseeker.partners',
    ),
  ];

  static const experiences = [
    ExperienceEntry(
      period: 'Nov 2023 to Present',
      role: 'Flutter Engineer',
      company: 'PT. Esensi Solusi Buana',
      location: 'Tangerang, Indonesia',
      productLinks: [
        ProductLink(
          label: 'ESB POSLite on Google Play',
          url: 'https://play.google.com/store/apps/details?id=id.co.esb.esb_pos&hl=id',
        ),
        ProductLink(
          label: 'OLIN by ESB on Google Play',
          url: 'https://play.google.com/store/apps/details?id=id.co.esb.esb_olin&hl=en',
        ),
      ],
      details: [
        'Engineer and maintain ESB POSLite and OLIN by ESB across mobile and tablet devices.',
        'Build and maintain Bluetooth, USB, and network printer connections alongside bank ECR payment terminal integrations in ESB POSLite.',
        'Develop OLIN by ESB chatbot interfaces with Text-to-Speech output, delivering 30+ UI screens and 10+ product features from Figma specifications.',
        'Refactored 5,000+ lines of legacy code and led the Flutter 2.x to 3.x migration while working around Angular, Go, and PHP services.',
        'Write Technical Specification Documents for 7+ features and use Claude for AI-assisted development alongside GitHub and Jira.',
      ],
      stackSummary:
          'Flutter, Dart, SQLite, Dio, Firebase, Printers, Bank ECR, Text-to-Speech, Angular, Go, PHP, Claude',
    ),
    ExperienceEntry(
      period: 'Jan 2022 to Nov 2022',
      role: 'Product Engineer (Front-End Flutter Developer)',
      company: 'Jobseeker Company',
      location: 'Jakarta, Indonesia',
      productLinks: [
        ProductLink(
          label: 'jobseeker.partners on Google Play',
          url: 'https://play.google.com/store/apps/details?id=com.jobseeker.partners',
        ),
      ],
      details: [
        'Delivered the jobseeker.partners Flutter app within a 7-month cycle with 5 mobile engineers and 4 departments.',
        'Migrated the project structure from layer-first modules to a feature-first modular architecture.',
        'Integrated 100+ RESTful API endpoints and third-party packages while converting Figma designs into reusable components.',
        'Diagnosed and resolved 80+ QA and production defects to stabilize releases.',
      ],
      stackSummary: 'Flutter, Dart, Feature-First Architecture, REST APIs, Figma',
    ),
    ExperienceEntry(
      period: 'Oct 2020 to Jun 2021',
      role: 'Software Engineer (Front-End Flutter, Remote Contract)',
      company: 'Belfarm.ID',
      location: 'Jakarta, Indonesia',
      details: [
        'Designed mobile user flows, wireframes, and UI screens in Figma and built the Flutter application end to end.',
        'Integrated backend RESTful APIs and third-party plugins, running iterative testing, debugging, and stakeholder reviews.',
      ],
      stackSummary: 'Flutter, Dart, Figma, REST APIs',
    ),
  ];

  static const stackRows = [
    StackRow(
      category: 'Mobile & web frameworks',
      items: ['Flutter (Mobile and Tablet)', 'Angular'],
    ),
    StackRow(
      category: 'Languages',
      items: ['Dart', 'Go', 'PHP', 'Java'],
    ),
    StackRow(
      category: 'State & architecture',
      items: ['BLoC', 'Cubit', 'GetX', 'Feature-first modular architecture'],
    ),
    StackRow(
      category: 'Networking & storage',
      items: ['RESTful APIs', 'Dio', 'Firebase', 'SQLite'],
    ),
    StackRow(
      category: 'Hardware, POS & AI',
      items: [
        'Bluetooth, USB, and network printers',
        'Bank ECR payment terminals',
        'AI chatbot UI',
        'Text-to-Speech (TTS)',
      ],
    ),
    StackRow(
      category: 'Workflow & tools',
      items: [
        'Git',
        'GitHub',
        'Jira',
        'Figma',
        'Visual Studio Code',
        'Claude (AI-assisted development)',
        'Technical specifications',
        'Agile / Scrum',
      ],
    ),
  ];

  static const education = EducationEntry(
    university: 'Universiti Utara Malaysia (UUM)',
    location: 'Sintok, Kedah, Malaysia',
    degree:
        'Bachelor of Science (Honours) in Information Technology, Majoring in Software Engineering',
    graduation: 'Graduated Nov 2020',
    cgpa: '3.61 / 4.00',
    honors: "Dean's List Award across 4 semesters (1st, 5th, 6th, and 7th)",
  );

  static const certification = 'UI/UX Gestalt Design, BuildWithAngga';
  static const languages =
      'Bahasa Indonesia (Native), English (Professional working proficiency)';
}
