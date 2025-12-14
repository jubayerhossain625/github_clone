class RepositoryEntity {
  final String name;
  final String owner;
  final String html_url;
  final String avatarUrl;
  final String description;
  final int stars;
  final DateTime updatedAt;

  RepositoryEntity({
    required this.name,
    required this.owner,
    required this.avatarUrl,
    required this.html_url,
    required this.description,
    required this.stars,
    required this.updatedAt,
  });
}