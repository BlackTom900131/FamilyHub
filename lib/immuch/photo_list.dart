import 'package:flutter/material.dart';

class PhotoList extends StatelessWidget {
  final List<PhotoItem> photos;

  const PhotoList({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: photos.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final photo = photos[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              photo.url,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(photo.title),
          subtitle: Text(photo.description),
          trailing: photo.trailing,
        );
      },
    );
  }
}

class PhotoItem {
  final String url;
  final String title;
  final String description;
  final Widget? trailing;

  PhotoItem({
    required this.url,
    required this.title,
    required this.description,
    this.trailing,
  });
}