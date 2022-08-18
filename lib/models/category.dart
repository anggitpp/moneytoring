enum CategoryType {
  income,
  expenses,
}

class Category {
  final int? id;
  final CategoryType categoryType;
  final String name;
  final String imagePath;

  const Category({
    this.id,
    required this.categoryType,
    required this.name,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'category_type':
          categoryType == CategoryType.income ? 'income' : 'expenses',
      'name': name,
      'image': imagePath,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) => Category(
        id: map['id'],
        categoryType: map['category_type'] == 'income'
            ? CategoryType.income
            : CategoryType.expenses,
        name: map['name'],
        imagePath: map['image'],
      );

  @override
  String toString() {
    return 'Category(id: $id, categoryType: $categoryType, name: $name, imagePath: $imagePath)';
  }
}
