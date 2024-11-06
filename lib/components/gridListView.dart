import 'package:bit_ascol/components/scrolling.dart';
import 'package:bit_ascol/screens/Home/syllabus/s_semster.dart';
import 'package:bit_ascol/services/router/router_name.dart';
import 'package:bit_ascol/utils/font_Style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../config/assetList.dart';
import '../screens/Home/questions/q_semester.dart';

class GridListView extends StatefulWidget {

  const GridListView({super.key});

  @override
  State<GridListView> createState() => _GridListViewState();
}

class _GridListViewState extends State<GridListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        Row(
          children: [
            Expanded(
              child: GridWidget(
                image: AssetsList.classroom,
                name: "ASCOL AI",
                onTap: () async {
                  Navigator.pushNamed(context, chatScreenPath);
                },
              ),
            ),
            Expanded(
              child: GridWidget(
                image: AssetsList.notebook,
                name: "Notes",
                onTap: () async {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => NotesScreen(isAdmin: isAdmin),
                  //   ),
                  // );
                   Navigator.pushNamed(context, notesScreenPath);
                },
              ),
            ),
          ],
        ),
        _buildPromoBanner(),
        Row(
          children: [
            Expanded(
              child: GridWidget(
                image: AssetsList.assignment,
                name: "Assignment",
                onTap: () async {
                  Navigator.pushNamed(context, assignmentPath);
                },
              ),
            ),
            Expanded(
              child: GridWidget(
                image: AssetsList.students,
                name: "Student List",
                onTap: () async {
                  Navigator.pushNamed(context, studentListPath);
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GridWidget(
                image: AssetsList.result,
                name: "Results",
                onTap: () async {
                  Navigator.pushNamed(context, resultPath);
                },
              ),
            ),
            Expanded(
              child: GridWidget(
                image: AssetsList.upcoming,
                name: "Upcoming Events",
                onTap: () async {
                  Navigator.pushNamed(context, upcomingEventPath);
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GridWidget(
                image: AssetsList.syllabus,
                name: "Syllabus",
                onTap: () async {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SyllabusSemScreen()));
                },
              ),
            ),
            Expanded(
              child: GridWidget(
                image: AssetsList.question,
                name: "Questions",
                onTap: () async {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuestionSemScreen()));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
class GridWidget extends StatelessWidget {
  final String image, name;
  final void Function()? onTap;
  const GridWidget({
    super.key,
    required this.image,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 5.0,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Center(
                  child: Image.asset(
                    image,
                    width: screenWidth < 600 ? 30.0 : 45.0,
                  ),
                ),
              ),
              const SizedBox(height: 3.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: textFormTitleStyle.copyWith(
                    fontSize: screenWidth < 600 ? 13.0 : 16.0,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



Widget _buildPromoBanner() {
  // List of local asset image URLs to display in the carousel
  final List<String> imageUrls = [
    AssetsList.first1,
    AssetsList.first2,
    AssetsList.second,
    // Add more image URLs as needed
  ];

  return CarouselSlider(
    options: CarouselOptions(
      height: 200,
      autoPlay: true,
      viewportFraction: 1.0,
    ),
    items: imageUrls.map((url) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.orange],
              ),
            ),
            child: Image.asset(
              url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50,
                );
              },
            ),
          );
        },
      );
    }).toList(),
  );
}
