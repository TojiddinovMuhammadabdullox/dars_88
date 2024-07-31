import 'package:dars_88/views/screens/booko_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:dars_88/models/book.dart';
import 'package:dars_88/views/widgets/book_card.dart';

class BestSellersScreen extends StatefulWidget {
  const BestSellersScreen({Key? key}) : super(key: key);

  @override
  _BestSellersScreenState createState() => _BestSellersScreenState();
}

class _BestSellersScreenState extends State<BestSellersScreen> {
  final List<Book> books = [
    Book(
      title: "1984 George Owell",
      author: "Holly Black",
      price: 9.99,
      rating: 7.0,
      imageUrl:
          "https://i.pinimg.com/736x/cc/c2/e1/ccc2e138cb23736edb1f35dfb464cc7f.jpg",
      fileUrl:
          "https://rauterberg.employee.id.tue.nl/lecturenotes/DDM110%20CAS/Orwell-1949%201984.pdf",
    ),
    Book(
      title: "Prejudice",
      author: "Holly Black",
      price: 9.99,
      rating: 7.0,
      imageUrl:
          "https://i.pinimg.com/736x/6d/c2/b2/6dc2b2e7d744f97e2488e8bc0a1d5f3c.jpg",
      fileUrl:
          "https://rauterberg.employee.id.tue.nl/lecturenotes/DDM110%20CAS/Orwell-1949%201984.pdf",
    ),
    Book(
      title: "The Great Getsby",
      author: "Holly Black",
      price: 9.99,
      rating: 7.0,
      imageUrl:
          "https://avatars.mds.yandex.net/get-mpic/5347553/img_id7956586197595381950.jpeg/orig",
      fileUrl:
          "https://rauterberg.employee.id.tue.nl/lecturenotes/DDM110%20CAS/Orwell-1949%201984.pdf",
    ),
    Book(
      title: "Kill A mockingbird",
      author: "Holly Black",
      price: 9.99,
      rating: 7.0,
      imageUrl:
          "https://i.pinimg.com/736x/6a/51/30/6a5130033af8c6b590084e2e56131daf.jpg",
      fileUrl:
          "https://rauterberg.employee.id.tue.nl/lecturenotes/DDM110%20CAS/Orwell-1949%201984.pdf",
    ),
    Book(
      title: "The Wolf Den",
      author: "Elodie Harper",
      price: 6.99,
      rating: 4.8,
      imageUrl:
          "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1570034831i/899488.jpg",
      fileUrl:
          "https://rauterberg.employee.id.tue.nl/lecturenotes/DDM110%20CAS/Orwell-1949%201984.pdf",
    ),
  ];

  late List<Book> filteredBooks;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredBooks = books;
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredBooks = books
          .where(
              (book) => book.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Sellers'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search books...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.6,
          ),
          itemCount: filteredBooks.length,
          itemBuilder: (context, index) {
            return BookCard(
              book: filteredBooks[index],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BookDetailsScreen(book: filteredBooks[index]),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
            );
          },
        ),
      ),
    );
  }
}
