enum WorkDomain { all, posHardware, aiVoice, recruitment }

class FactRow {
  const FactRow({required this.label, required this.value});

  final String label;
  final String value;
}

class StackRow {
  const StackRow({required this.category, required this.items});

  final String category;
  final List<String> items;
}

class ProductLink {
  const ProductLink({required this.label, required this.url});

  final String label;
  final String url;
}

class ExperienceEntry {
  const ExperienceEntry({
    required this.period,
    required this.role,
    required this.company,
    required this.location,
    required this.details,
    required this.stackSummary,
    this.productLinks = const [],
  });

  final String period;
  final String role;
  final String company;
  final String location;
  final List<String> details;
  final String stackSummary;
  final List<ProductLink> productLinks;
}

class WorkProject {
  const WorkProject({
    required this.index,
    required this.name,
    required this.category,
    required this.company,
    required this.period,
    required this.domain,
    required this.summary,
    required this.engineeringNotes,
    required this.architectureSpecs,
    required this.stack,
    required this.playStoreUrl,
    this.isPrimary = false,
  });

  final String index;
  final String name;
  final String category;
  final String company;
  final String period;
  final WorkDomain domain;
  final String summary;
  final List<String> engineeringNotes;
  final List<FactRow> architectureSpecs;
  final List<String> stack;
  final String playStoreUrl;
  final bool isPrimary;
}

class EducationEntry {
  const EducationEntry({
    required this.university,
    required this.location,
    required this.degree,
    required this.graduation,
    required this.cgpa,
    required this.honors,
  });

  final String university;
  final String location;
  final String degree;
  final String graduation;
  final String cgpa;
  final String honors;
}
