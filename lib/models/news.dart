class News {
  final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final DateTime publishedAt;
  final String content;

  News({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.content
  });

  // Convert json to news object
  factory News.fromJson(Map<String, dynamic> _json) {
    return News(
      source: _json["source"]!["name"] ?? "",
      author: _json["author"] ?? "",
      title: _json["title"] ?? "",
      description: _json["description"] ?? "",
      url: _json["url"] ?? "",
      imageUrl: _json["urlToImage"] ?? "",
      publishedAt: _json["publishedAt"] != null ? DateTime.parse(_json["publishedAt"]) : DateTime.now(),
      content: _json["content"] ?? ""
    );
  }

  // Convert news object to json
  Map<String, dynamic> toJson(News _news) {
    return {
      "source": _news.source,
      "author": _news.author,
      "title": _news.title,
      "description": _news.description,
      "url": _news.url,
      "urlToImage": _news.imageUrl,
      "publishedAt": _news.publishedAt.toString(),
      "content": _news.content,
    };
  }
}