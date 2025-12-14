class RepositoryEntity {
  final String name;
  final String owner;
  final String avatarUrl;
  final String description;
  final int stars;
  final DateTime updatedAt;

  RepositoryEntity({
    required this.name,
    required this.owner,
    required this.avatarUrl,
    required this.description,
    required this.stars,
    required this.updatedAt,
  });
}