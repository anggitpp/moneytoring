class Category {
  final int id;
  final String name;
  final String imagePath;
  Category({
    required this.id,
    required this.name,
    required this.imagePath,
  });
}

final List<Category> dummyCategories = [
  Category(
      id: 1, name: 'Aquarium Kaca', imagePath: 'assets/icon/icon-aquarium.png'),
  Category(id: 2, name: 'Smart Device', imagePath: 'assets/icon/icon-bulb.png'),
  Category(
      id: 3, name: 'Electronic', imagePath: 'assets/icon/icon-electronic.png'),
];
