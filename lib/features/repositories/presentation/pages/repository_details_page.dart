import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/repository_entity.dart';

class RepositoryDetailsPage extends StatelessWidget {
  final RepositoryEntity repo;

  const RepositoryDetailsPage({super.key, required this.repo});

  // 🔗 Open GitHub profile
  Future<void> _openGitHubProfile() async {
    final url = Uri.parse(repo.html_url);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repo.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.language,color: Colors.blue,),
            tooltip: 'Open GitHub Profile',
            onPressed: _openGitHubProfile,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to full screen photo view
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(title: Text(repo.owner)),
                      body: PhotoView(
                        imageProvider: NetworkImage(repo.avatarUrl),
                        backgroundDecoration: const BoxDecoration(color: Colors.black),
                      ),
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(repo.avatarUrl),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _openGitHubProfile,
              child: Text('Owner: ${repo.owner}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.blue)),
            ),
            // Text('Owner: ${repo.owner}',
            //     style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(repo.description),
            const SizedBox(height: 8),
            Text('⭐ Stars: ${repo.stars}'),
            const SizedBox(height: 8),
            Text('Updated: ${formatDateAge(repo.updatedAt)}'),
            const SizedBox(height: 8),
            Text('Updated: ${formatDate(repo.updatedAt)}'),
          ],
        ),
      ),
    );
  }
}