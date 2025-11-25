
class MealRecipe {

  final String id;
  final String name;
  final String instructions;
  final List<String> ingredients;
  final String thumbUrl;
  final String youtubeUrl;

  MealRecipe({required this.id, required this.name, required this.instructions, required this.ingredients, required this.thumbUrl, required this.youtubeUrl});
  MealRecipe.emptyInstance({
    this.id = "",
    this.name = "",
    this.instructions = "",
    List<String>? ingredients,
    this.thumbUrl = "",
    this.youtubeUrl = "",
  }) : ingredients = ingredients ?? [];

  @override
  String toString() => "${id}, ${name}";

  @override
  bool operator ==(Object other) {
    return other is MealRecipe &&
      id == other.id;
  }

  @override
  int get hashCode => Object.hash(id, name);

}