class Category {
  const Category({
    required this.id,
    required this.sort,
    required this.categoryName,
    required this.status,
  });
  final int id;
  final int sort;
  final String categoryName;
  final bool status;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      sort: json['sort'],
      categoryName: json['categoryName'],
      status: json['status'],
    );
  }

  @override
  String toString() {
    return 'Category(id: $id, sort: $sort, categoryName: $categoryName, status: $status)';
  }
}
