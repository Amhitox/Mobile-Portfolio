import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text(
            'My Projects',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
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
                  childAspectRatio: 1.2,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) => ProjectCard(
                  project: projects[index],
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

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
                child: Image.asset(
                  project.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) return child;
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: frame != null
                          ? child
                          : Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  project.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    if (project.githubUrl != null)
                      IconButton(
                        icon: const Icon(Icons.code),
                        onPressed: () {
                          // Handle GitHub link tap
                          _showLinkDialog(context, 'GitHub', project.githubUrl!);
                        },
                        tooltip: 'View Code',
                      ),
                    if (project.liveUrl != null)
                      IconButton(
                        icon: const Icon(Icons.launch),
                        onPressed: () {
                          // Handle Live Demo link tap
                          _showLinkDialog(context, 'Live Demo', project.liveUrl!);
                        },
                        tooltip: 'Live Demo',
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLinkDialog(BuildContext context, String title, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Open $title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Link:'),
              const SizedBox(height: 8),
              SelectableText(url),
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