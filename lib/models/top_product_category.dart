import 'dart:convert';

class TopProductCategory {
  final String title;
  final int value;
  TopProductCategory({
    required this.title,
    required this.value,
  });

  @override
  String toString() => 'TopProductCategory(title: $title, value: $value)';

  Map<String, dynamic> toMap() {
    return {
      'name': title,
      'totalQuantity': value,
    };
  }

  factory TopProductCategory.fromMap(Map<String, dynamic> map) {
    return TopProductCategory(
      title: map['name'] ?? '',
      value: map['totalQuantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TopProductCategory.fromJson(String source) =>
      TopProductCategory.fromMap(json.decode(source));
}
