import 'package:flutter/material.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/repository_entity.dart';
import '../pages/repository_details_page.dart';

class RepositoryTile extends StatelessWidget {
  final RepositoryEntity repo;

  const RepositoryTile({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(repo.avatarUrl)),
      title: Text(repo.name),
      subtitle: Text(repo.owner),
      trailing: Text('⭐ ${repo.stars}\n${formatDateAge(repo.updatedAt)}',textAlign: TextAlign.end,),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RepositoryDetailsPage(repo: repo),
        ),
      ),
    );
  }
}