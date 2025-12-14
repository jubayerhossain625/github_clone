import '../../domain/entities/repository_entity.dart';

class RepositoryModel extends RepositoryEntity {
  RepositoryModel({
    required super.name,
    required super.owner,
    required super.avatarUrl,
    required super.description,
    required super.stars,
    required super.updatedAt,
    required super.html_url,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      name: json['name'],
      owner: json['owner']['login'],
      avatarUrl: json['owner']['avatar_url'],
      description: json['description'] ?? '',
      stars: json['stargazers_count'],
      updatedAt: DateTime.parse(json['updated_at']),
      html_url: json['html_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'owner': owner,
    'avatarUrl': avatarUrl,
    'html_url':html_url,
    'description': description,
    'stars': stars,
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory RepositoryModel.fromLocal(Map<String, dynamic> json) {
    return RepositoryModel(
      name: json['name'],
      owner: json['owner'],
      avatarUrl: json['avatarUrl'],
      html_url:'html_url',
      description: json['description'],
      stars: json['stars'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}