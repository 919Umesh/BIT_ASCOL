import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventDetails extends StatelessWidget {
  final String title;
  final String description;
  final String fileUrl;
  final String datetime;

  const EventDetails({
    Key? key,
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.datetime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(title,style: TextStyle(color: Colors.white),),
      //   backgroundColor: primaryColor, // Use the primary color for the app bar
      // ),
      appBar: AppBar(
        title: const Text("Details",style: TextStyle(color: Colors.white),),
        backgroundColor: primaryColor, // Use primaryColor for AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Event:${title}",
                style: textTheme.headlineMedium?.copyWith(color: primaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                "Description: ${description}",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              if (fileUrl.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoViewScreen(
                          imageUrl: fileUrl,
                        ),
                      ),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: fileUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                'Date & Time: ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(datetime))}',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoViewScreen extends StatelessWidget {
  final String imageUrl;

  const PhotoViewScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Zoomable Image'),
        backgroundColor: primaryColor, // Use the primary color for the app bar
      ),
      body: PhotoViewGallery.builder(
        itemCount: 1,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(imageUrl), // Use CachedNetworkImageProvider for caching
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
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
