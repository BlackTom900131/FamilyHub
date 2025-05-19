import 'package:flutter/material.dart';

import 'photo_gallery_item.dart';

class PhotoGallery extends StatelessWidget {
  final List<String> imageUrls;

  const PhotoGallery({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align title to left
        children: [
          const SizedBox(height: 12), // Space between title and grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  // child: Image.network(
                  //   imageUrls[index],
                  //   fit: BoxFit.cover,
                  // ),
                  child: PhotoGalleryItem(
                    imageUrls: [
                      'https://picsum.photos/id/1011/100/100',
                      'https://picsum.photos/id/1012/100/100',
                      'https://picsum.photos/id/1013/100/100',
                      'https://picsum.photos/id/1014/100/100',
                    ],
                    title: "",
                    subtitle: 'A fun',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// void main() {
//   runApp(
//     MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Photo Gallery'),
//         ),
//         body: PhotoGallery(
//           imageUrls: [
//             'https://picsum.photos/id/1011/200/200',
//             'https://picsum.photos/id/1012/200/200',
//             'https://picsum.photos/id/1013/200/200',
//             // Add more URLs as needed
//           ],
//         ),
//       ),
//     ),
//   );
// }