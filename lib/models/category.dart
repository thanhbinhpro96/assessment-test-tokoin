class Category {
  final String keyword;

  Category({required this.keyword});

  // Convert json to category object
  factory Category.fromJson(Map<String, dynamic> _json) {
    return Category(
      keyword: _json["keyword"] ?? ""
    );
  }

  // Convert category object to json
  Map<String, dynamic> toJson(Category _category) {
    return {
      "keyword": _category.keyword
    };
  }
}