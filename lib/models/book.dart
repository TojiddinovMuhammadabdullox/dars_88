class Book {
  final String title;
  final String author;
  final double price;
  final double rating;
  final String imageUrl;
  bool isLoading;
  bool isDownloaded;
  final String fileUrl;

  Book({
    required this.title,
    required this.author,
    required this.price,
    required this.rating,
    required this.imageUrl,
    this.isDownloaded = false,
    this.isLoading = false,
    required this.fileUrl,
  });
}
