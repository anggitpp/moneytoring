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
      'id': id,
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

final List<Category> dummyCategories = [
  Category(
    id: 1,
    categoryType: CategoryType.income,
    name: 'Aquarium Kaca',
    imagePath: 'assets/icon/icon-aquarium.png',
  ),
  Category(
    id: 2,
    categoryType: CategoryType.income,
    name: 'Smart Device',
    imagePath: 'assets/icon/icon-bulb.png',
  ),
  Category(
    id: 3,
    categoryType: CategoryType.income,
    name: 'Electronic',
    imagePath: 'assets/icon/icon-electronic.png',
  ),
  Category(
    id: 4,
    categoryType: CategoryType.expenses,
    name: 'Aquarium Kaca',
    imagePath: 'assets/icon/icon-aquarium.png',
  ),
  Category(
    id: 5,
    categoryType: CategoryType.expenses,
    name: 'Smart Device',
    imagePath: 'assets/icon/icon-bulb.png',
  ),
  Category(
    id: 6,
    categoryType: CategoryType.expenses,
    name: 'Electronic',
    imagePath: 'assets/icon/icon-electronic.png',
  ),
  Category(
    id: 7,
    categoryType: CategoryType.expenses,
    name: 'Peralatan',
    imagePath: 'assets/icon/icon-electronic.png',
  ),
];
