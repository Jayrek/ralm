class Avatar {
  const Avatar({
    required this.id,
    required this.category,
    required this.image,
    required this.isSelected,
    required this.isLocked,
  });

  final int id;
  final String category;
  final String image;
  final bool isSelected;
  final bool isLocked;

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      id: json['id'],
      category: json['category'],
      image: json['image'],
      isSelected: json['is_selected'],
      isLocked: json['is_locked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'image': image,
      'is_selected': isSelected,
      'is_locked': isLocked,
    };
  }

  Avatar copyWith({
    final int? id,
    final String? category,
    final String? image,
    final bool? isSelected,
    final bool? isLocked,
  }) {
    return Avatar(
      id: id ?? this.id,
      category: category ?? this.category,
      image: image ?? this.image,
      isSelected: isSelected ?? this.isSelected,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  @override
  String toString() {
    return 'Avatar(id: $id, category: $category, image: $image, isSelected: $isSelected, isLocked: $isLocked)';
  }
}
