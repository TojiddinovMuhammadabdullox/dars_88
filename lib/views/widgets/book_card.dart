import 'package:flutter/material.dart';
import 'package:dars_88/models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onPressed;

  const BookCard({Key? key, required this.book, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 10,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                book.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(book.author),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const SizedBox(width: 4),
                    Text(book.rating.toString()),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${book.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: book.isDownloaded
                ? Icon(Icons.check_circle, color: Colors.green)
                : IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: onPressed,
                  ),
          ),
        ],
      ),
    );
  }
}
