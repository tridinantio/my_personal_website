import 'package:flutter/material.dart';

class HeroStat {
  const HeroStat({required this.value, required this.label});

  final String value;
  final String label;
}

class SkillGroup {
  const SkillGroup({
    required this.title,
    required this.icon,
    required this.accent,
    required this.skills,
  });

  final String title;
  final IconData icon;
  final Color accent;
  final List<String> skills;
}

class ProductLink {
  const ProductLink({required this.label, required this.url});

  final String label;
  final String url;
}

class ExperienceItemData {
  const ExperienceItemData({
    required this.period,
    required this.role,
    required this.company,
    required this.location,
    required this.details,
    required this.techStack,
    this.productLinks = const [],
  });

  final String period;
  final String role;
  final String company;
  final String location;
  final List<String> details;
  final List<String> techStack;
  final List<ProductLink> productLinks;
}

class ProjectItemData {
  const ProjectItemData({
    required this.number,
    required this.name,
    required this.category,
    required this.company,
    required this.summary,
    required this.highlights,
    required this.techStack,
    required this.accent,
    required this.icon,
    required this.badgeLabel,
    this.playStoreUrl,
  });

  final String number;
  final String name;
  final String category;
  final String company;
  final String summary;
  final List<String> highlights;
  final List<String> techStack;
  final Color accent;
  final IconData icon;
  final String badgeLabel;
  final String? playStoreUrl;
}

class EducationData {
  const EducationData({
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
