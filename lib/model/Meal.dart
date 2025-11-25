
class Meal {

  final String id;
  final String name;
  final String thumbUrl;

  Meal({required this.id, required this.name, required this.thumbUrl});

  @override
  String toString() => "${id}, ${name}";

  @override
  bool operator ==(Object other) {
    return other is Meal &&
      id == other.id;
  }

  @override
  int get hashCode => Object.hash(id, name);
}