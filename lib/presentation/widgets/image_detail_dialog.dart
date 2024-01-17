import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageDetailsDialog extends StatelessWidget {
  final String imageUrl;
  final String id;
  final String author;
  final String url;
  final int height;
  final int width;

  const ImageDetailsDialog({
    Key? key,
    required this.imageUrl,
    required this.id,
    required this.author,
    required this.url,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height*0.90,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              height: 200, // Adjust the height as needed
            ),
            const SizedBox(height: 16),
            buildTextRow("ID:", id),
            buildTextRow("Author:", author),
            buildTextRow("URL:", url),
            buildTextRow("Height:", height.toString()),
            buildTextRow("Width:", width.toString()),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(fontSize: 14.0,color:Colors.black),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
