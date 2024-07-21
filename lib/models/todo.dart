class Todo {
  final int id;
  final String title;
  final String category;
  final String price;
  final String dateCreated;
  final String? dateUpdated;
  Todo({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.dateCreated,
    this.dateUpdated,
  });
}
