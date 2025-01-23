import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/const.dart';

class PhotoViewScreen extends StatelessWidget {
  final String imageUrl;

  const PhotoViewScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zoomable Image'),
        backgroundColor: primaryColor,
      ),
      body: PhotoViewGallery.builder(
        itemCount: 1,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(imageUrl),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
      ),
    );
  }
}
