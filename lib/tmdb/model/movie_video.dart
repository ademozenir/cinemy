class Video {
  Video({
    required this.name,
    required this.key,
    required this.publishedAt,
    required this.site,
    required this.size,
    required this.type,
    required this.id,
  });

  String name;
  String key;
  String publishedAt;
  String site;
  int size;
  String type;
  String id;

  factory Video.fromJson(Map<String, dynamic> map) {
    return Video(
      name: map["name"] ?? "",
      key: map["key"] ?? "",
      publishedAt: map["published_at"] ?? "",
      site: map["site"] ?? "",
      size: map["size"] ?? 0,
      type: map["type"] ?? "",
      id: map["id"] ?? "",
    );
  }

  @override
  String toString() {
    return 'Video{name: $name, key: $key, publishedAt: $publishedAt,'
        ' site: $site, size: $size, type: $type, id: $id}';
  }
}
