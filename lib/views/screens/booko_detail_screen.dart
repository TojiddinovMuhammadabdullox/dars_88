import 'package:flutter/material.dart';
import 'package:dars_88/models/book.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  double _downloadProgress = 0;

  Future<bool> requestStoragePermission() async {
    if (await Permission.storage.isGranted) {
      return true;
    } else {
      final result = await Permission.storage.request();
      return result.isGranted;
    }
  }

  Future<void> downloadFile(BuildContext context) async {
    final dio = Dio();
    if (await requestStoragePermission()) {
      final savePath = await getApplicationDocumentsDirectory();
      final fileName = "1984.pdf";
      final filePath = "${savePath.path}/$fileName";

      try {
        setState(() {
          widget.book.isLoading = true;
        });

        await dio.download(
          "https://rauterberg.employee.id.tue.nl/lecturenotes/DDM110%20CAS/Orwell-1949%201984.pdf",
          filePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              setState(() {
                _downloadProgress = received / total;
              });
            }
          },
        );

        setState(() {
          widget.book.isDownloaded = true;
          widget.book.isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File downloaded to $filePath')),
        );
      } catch (e) {
        setState(() {
          widget.book.isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.book.imageUrl,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.book.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'by ${widget.book.author}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text('Rating: ${widget.book.rating}'),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Price: \$${widget.book.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              if (widget.book.isLoading)
                Column(
                  children: [
                    LinearProgressIndicator(value: _downloadProgress),
                    const SizedBox(height: 8),
                    Text(
                        'Downloading: ${(_downloadProgress * 100).toStringAsFixed(0)}%'),
                  ],
                )
              else if (!widget.book.isDownloaded)
                ElevatedButton(
                  onPressed: () => downloadFile(context),
                  child: const Text("DOWNLOAD"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                )
              else
                Text(
                  "Downloaded",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
