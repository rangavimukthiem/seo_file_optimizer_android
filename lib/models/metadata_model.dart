class MetadataModel {
  String title;
  String description;
  List<String> keywords;
  String author;
  String? altText;

  MetadataModel({
    required this.title,
    required this.description,
    required this.keywords,
    required this.author,
    this.altText,
  });
}
