import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 24.0),
      child: Column(
        children: [
          Text(
            'Skills',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildSkillCategory(
                    context,
                    'Frontend Development',
                    frontendSkills,
                    Icons.desktop_windows,
                    Colors.blue,
                  ),
                  _buildSkillCategory(
                    context,
                    'Backend Development',
                    backendSkills,
                    Icons.storage,
                    Colors.green,
                  ),
                  _buildSkillCategory(
                    context,
                    'Mobile Development',
                    mobileSkills,
                    Icons.mobile_friendly,
                    Colors.orange,
                  ),
                  _buildSkillCategory(
                    context,
                    'Tools & Others',
                    toolsSkills,
                    Icons.build,
                    Colors.purple,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildSkillCategory(
    BuildContext context,
    String title,
    List<Skill> skills,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          ...skills.map((skill) => SkillItem(skill: skill)),
        ],
      ),
    );
  }
}

class SkillItem extends StatelessWidget {
  final Skill skill;

  const SkillItem({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.name,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                '${(skill.proficiency * 100).toInt()}%',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: skill.proficiency,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              skill.proficiency > 0.8
                  ? Colors.green
                  : skill.proficiency > 0.6
                      ? Colors.blue
                      : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

class Skill {
  final String name;
  final double proficiency; // 0.0 to 1.0

  const Skill({
    required this.name,
    required this.proficiency,
  });
}

// Sample skill data
final List<Skill> frontendSkills = [
  const Skill(name: 'HTML/CSS', proficiency: 0.9),
  const Skill(name: 'JavaScript', proficiency: 0.85),
  const Skill(name: 'React', proficiency: 0.8),
];

final List<Skill> backendSkills = [
  const Skill(name: 'Node.js', proficiency: 0.75),
  const Skill(name: 'Python', proficiency: 0.7),
  const Skill(name: 'Firebase', proficiency: 0.85),
];

final List<Skill> mobileSkills = [
  const Skill(name: 'Flutter', proficiency: 0.9),
  const Skill(name: 'Dart', proficiency: 0.85),
  const Skill(name: 'React Native', proficiency: 0.7),
];

final List<Skill> toolsSkills = [
  const Skill(name: 'Git', proficiency: 0.85),
  const Skill(name: 'Docker', proficiency: 0.7),
  const Skill(name: 'VS Code', proficiency: 0.9),
]; 