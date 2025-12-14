import 'package:flutter/material.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/repository_entity.dart';

class RepositoryDetailsPage extends StatelessWidget {
  final RepositoryEntity repo;

  const RepositoryDetailsPage({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(repo.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(repo.avatarUrl),
            ),
            const SizedBox(height: 16),
            Text('Owner: ${repo.owner}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(repo.description),
            const SizedBox(height: 8),
            Text('⭐ Stars: ${repo.stars}'),
            const SizedBox(height: 8),
            Text('Updated: ${formatDate(repo.updatedAt)}'),
          ],
        ),
      ),
    );
  }
}