// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// class EventDetails extends StatelessWidget {
//   final String title;
//   final String description;
//   final String fileUrl;
//   final String datetime;
//
//   const EventDetails({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.fileUrl,
//     required this.datetime,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     final primaryColor = Theme.of(context).primaryColor;
//
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(title,style: TextStyle(color: Colors.white),),
//       //   backgroundColor: primaryColor, // Use the primary color for the app bar
//       // ),
//       appBar: AppBar(
//         title: const Text("Details",style: TextStyle(color: Colors.white),),
//         backgroundColor: primaryColor, // Use primaryColor for AppBar
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Event:${title}",
//                 style: textTheme.headlineMedium?.copyWith(color: primaryColor),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 "Description: ${description}",
//                 style: textTheme.bodyMedium,
//               ),
//               const SizedBox(height: 16),
//               if (fileUrl.isNotEmpty)
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => PhotoViewScreen(
//                           imageUrl: fileUrl,
//                         ),
//                       ),
//                     );
//                   },
//                   child: CachedNetworkImage(
//                     imageUrl: fileUrl,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
//                     errorWidget: (context, url, error) => const Icon(Icons.error),
//                   ),
//                 ),
//               const SizedBox(height: 16),
//               Text(
//                 'Date & Time: ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(datetime))}',
//                 style: textTheme.bodyMedium,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class PhotoViewScreen extends StatelessWidget {
//   final String imageUrl;
//
//   const PhotoViewScreen({Key? key, required this.imageUrl}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = Theme.of(context).primaryColor;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Zoomable Image'),
//         backgroundColor: primaryColor, // Use the primary color for the app bar
//       ),
//       body: PhotoViewGallery.builder(
//         itemCount: 1,
//         builder: (context, index) {
//           return PhotoViewGalleryPageOptions(
//             imageProvider: CachedNetworkImageProvider(imageUrl), // Use CachedNetworkImageProvider for caching
//             minScale: PhotoViewComputedScale.contained,
//             maxScale: PhotoViewComputedScale.covered * 2,
//           );
//         },
//         scrollPhysics: const BouncingScrollPhysics(),
//         backgroundDecoration: const BoxDecoration(
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
// }

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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Event Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {
              // Add share functionality here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (fileUrl.isNotEmpty)
              Stack(
                children: [
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
                    child: Hero(
                      tag: 'eventImage',
                      child: CachedNetworkImage(
                        imageUrl: fileUrl,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 250,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 250,
                          color: Colors.grey[200],
                          child: const Icon(Icons.error, size: 50),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.touch_app,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Tap to zoom',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.headlineSmall?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            DateFormat('EEEE, MMMM d, yyyy – h:mm a')
                                .format(DateTime.parse(datetime)),
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'About Event',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Hero(
        tag: 'eventImage',
        child: PhotoViewGallery.builder(
          itemCount: 1,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(imageUrl),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
              initialScale: PhotoViewComputedScale.contained,
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          loadingBuilder: (context, event) => const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}