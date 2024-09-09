// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// class AssignmentDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> assignment;
//
//   const AssignmentDetailScreen({super.key, required this.assignment});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Assignment Details'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 8.0),
//             Text('Date: ${assignment['datetime']}'),
//             const SizedBox(height: 8.0),
//             Text(assignment['description'] ?? 'No Description'),
//             if (assignment['imageUrl'] != null && assignment['imageUrl']!.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(top: 16.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => PhotoViewScreen(
//                           imageUrl: assignment['imageUrl']!,
//                         ),
//                       ),
//                     );
//                   },
//                   child: CachedNetworkImage(
//                     imageUrl: assignment['imageUrl']!,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
//                     errorWidget: (context, url, error) => const Icon(Icons.error),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class PhotoViewScreen extends StatelessWidget {
//   final String imageUrl;
//
//   const PhotoViewScreen({super.key, required this.imageUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Zoomable Image'),
//       ),
//       body: PhotoViewGallery.builder(
//         itemCount: 1,
//         builder: (context, index) {
//           return PhotoViewGalleryPageOptions(
//             imageProvider: CachedNetworkImageProvider(imageUrl),
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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../config/const.dart';
import '../result/result_details.dart'; // For date formatting

class AssignmentDetailScreen extends StatelessWidget {
  final Map<String, dynamic> assignment;

  const AssignmentDetailScreen({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(assignment['datetime']);
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final formattedTime = DateFormat('HH:mm').format(date);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment Details'),
        backgroundColor: primaryColor, // Use primary color for AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description: ${assignment['description'] ?? 'No Description'}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  'Date: $formattedDate',
                  style: TextStyle(color: hintColor, fontSize: 16),
                ),
                if (assignment['imageUrl'] != null &&
                    assignment['imageUrl']!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhotoViewScreen(
                              imageUrl: assignment['imageUrl']!,
                            ),
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: assignment['imageUrl']!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
