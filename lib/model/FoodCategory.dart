
class FoodCategory {

  final String id;
  final String name;
  final String description;
  final String thumbUrl;

  FoodCategory({required this.id, required this.name, required this.description, required this.thumbUrl});

  @override
  String toString() => "${id}, ${name}";

  @override
  bool operator ==(Object other) {
    return other is FoodCategory &&
      id == other.id;
  }

  @override
  int get hashCode => Object.hash(id, name, description);

}