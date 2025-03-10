class SubCategory {
  const SubCategory({
    required this.id,
    required this.categoryId,
    required this.sort,
    required this.categoryName,
    required this.categoryDescription,
    required this.status,
  });

  final int id;
  final int categoryId;
  final int sort;
  final String categoryName;
  final String categoryDescription;
  final bool status;

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      categoryId: json['category_id'],
      sort: json['sort'],
      categoryName: json['category_name'],
      categoryDescription: json['category_description'],
      status: json['status'],
    );
  }

  @override
  String toString() {
    return 'SubCategory(id: $id, categoryId: $categoryId, sort: $sort, categoryName: $categoryName, categoryDescription: $categoryDescription, status: $status)';
  }
}
