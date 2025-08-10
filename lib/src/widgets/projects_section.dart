import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = List.generate(4, (i) => 'Project ${i + 1}');
    return Container(
      key: const Key('Projects'),
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        children: [
          const Text(
            'Projects',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 900 ? 2 : 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 3,
            children: projects
                .map(
                  (p) => Card(
                    child: ListTile(
                      title: Text(p),
                      subtitle: const Text('Short description of the project.'),
                      trailing: IconButton(
                        icon: const Icon(Icons.open_in_new),
                        onPressed: () {},
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
