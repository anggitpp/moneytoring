enum CategoryType {
  income,
  expenses,
}

class Category {
  final int id;
  final CategoryType categoryType;
  final String name;
  final String imagePath;
  Category({
    required this.id,
    required this.categoryType,
    required this.name,
    required this.imagePath,
  });
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
