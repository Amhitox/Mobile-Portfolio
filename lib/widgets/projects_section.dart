import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surface,
          ],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 24.0),
        child: Column(
          children: [
            Text(
              'Featured Projects',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn().slideY(begin: -0.2),
            const SizedBox(height: 40),
            LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constraints.maxWidth > 1000 ? 3 : 
                                  constraints.maxWidth > 600 ? 2 : 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: projects.length,
                  itemBuilder: (context, index) => ProjectCard(
                    project: projects[index],
                    index: index,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;
  final int index;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, isHovered ? -10.0 : 0.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.black12,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(isHovered ? 0.2 : 0.1),
                spreadRadius: isHovered ? 8 : 2,
                blurRadius: isHovered ? 24 : 12,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        widget.project.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Theme.of(context).colorScheme.surface,
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 40,
                                color: Theme.of(context).iconTheme.color?.withOpacity(0.3),
                              ),
                            ),
                          );
                        },
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isHovered ? 1.0 : 0.0,
                        child: Container(
                          color: Theme.of(context).colorScheme.background.withOpacity(0.9),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.project.githubUrl != null)
                                _buildActionButton(
                                  context,
                                  'View Code',
                                  Icons.code,
                                  () => _showLinkDialog(context, 'GitHub', widget.project.githubUrl!),
                                ),
                              if (widget.project.liveUrl != null) ...[
                                const SizedBox(height: 12),
                                _buildActionButton(
                                  context,
                                  'Live Demo',
                                  Icons.launch,
                                  () => _showLinkDialog(context, 'Live Demo', widget.project.liveUrl!),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.project.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.project.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ).animate(
        delay: (widget.index * 100).milliseconds,
      ).fadeIn().slideY(begin: 0.2),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      hoverColor: Theme.of(context).primaryColor.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showLinkDialog(BuildContext context, String title, String url) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: isDark ? Colors.white10 : Colors.black12,
            ),
          ),
          title: Text(
            'Open $title',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Link:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark ? Colors.white10 : Colors.black12,
                  ),
                ),
                child: SelectableText(
                  url,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class Project {
  final String title;
  final String description;
  final String imageUrl;
  final String? githubUrl;
  final String? liveUrl;

  const Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    this.githubUrl,
    this.liveUrl,
  });
}

// Sample project data
final List<Project> projects = [
  const Project(
    title: 'E-Commerce App',
    description: 'A full-featured e-commerce application built with Flutter and Firebase.',
    imageUrl: 'assets/projects/ecommerce.jpeg',
    githubUrl: 'https://github.com/yourusername/ecommerce-app',
    liveUrl: 'https://ecommerce-app.com',
  ),
  const Project(
    title: 'Weather App',
    description: 'Real-time weather application using OpenWeather API.',
    imageUrl: 'assets/projects/weather.png',
    githubUrl: 'https://github.com/yourusername/weather-app',
  ),
  const Project(
    title: 'Task Manager',
    description: 'A beautiful task management app with local storage and notifications.',
    imageUrl: 'assets/projects/tasks.png',
    githubUrl: 'https://github.com/yourusername/task-manager',
    liveUrl: 'https://task-manager-app.com',
  ),
]; 