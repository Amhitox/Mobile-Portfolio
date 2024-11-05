import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[900]!,
            Colors.grey[850]!,
            Colors.grey[800]!,
          ],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 24.0),
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.white, Colors.white70],
              ).createShader(bounds),
              child: Text(
                'Skills & Expertise',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).animate().fadeIn().slideY(
              begin: -0.2,
              curve: Curves.easeOut,
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
                      const Color(0xFF64B5F6),
                    ),
                    _buildSkillCategory(
                      context,
                      'Backend Development',
                      backendSkills,
                      Icons.storage,
                      const Color(0xFF81C784),
                    ),
                    _buildSkillCategory(
                      context,
                      'Mobile Development',
                      mobileSkills,
                      Icons.mobile_friendly,
                      const Color(0xFFFFB74D),
                    ),
                    _buildSkillCategory(
                      context,
                      'Tools & Others',
                      toolsSkills,
                      Icons.build,
                      const Color(0xFFBA68C8),
                    ),
                  ].asMap().entries.map((entry) {
                    return entry.value.animate(
                      delay: (entry.key * 200).milliseconds,
                    ).fadeIn().slideX(
                      begin: entry.key.isEven ? -0.2 : 0.2,
                      curve: Curves.easeOut,
                    );
                  }).toList(),
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
      width: 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white10,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              size: 40,
              color: color,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          ...skills.asMap().entries.map((entry) {
            return SkillItem(
              skill: entry.value,
              color: color,
              delay: entry.key * 200,
            );
          }),
        ],
      ),
    );
  }
}

class SkillItem extends StatelessWidget {
  final Skill skill;
  final Color color;
  final int delay;

  const SkillItem({
    super.key,
    required this.skill,
    required this.color,
    required this.delay,
  });

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
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              Text(
                '${(skill.proficiency * 100).toInt()}%',
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    height: 8,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeOut,
                    height: 8,
                    width: constraints.maxWidth * skill.proficiency,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.5),
                          blurRadius: 6,
                          spreadRadius: -1,
                        ),
                      ],
                    ),
                  ).animate(
                    delay: delay.milliseconds,
                  ).slideX(
                    begin: -1,
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeOut,
                  ),
                ],
              );
            },
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