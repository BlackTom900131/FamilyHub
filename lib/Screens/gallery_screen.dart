import 'package:flutter/material.dart';

import '../immuch/photo_gallery.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Photos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.lightBlue[50],
                hintText: 'Search photos',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            child: PhotoGallery(
              imageUrls: [
                'https://picsum.photos/id/1011/200/200',
                'https://picsum.photos/id/1012/200/200',
                'https://picsum.photos/id/1013/200/200',
                // Add more URLs as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
