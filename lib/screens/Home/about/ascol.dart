import 'package:flutter/material.dart';

class AboutAscol extends StatelessWidget {
  const AboutAscol({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amrit Science Campus'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction
            _sectionTitle('Amrit Science Campus'),
            _sectionContent(
                'Lainchaur, Kathmandu\n\n'
            ),
            Image.asset(
              'assets/images/logoASCOL.png',
              fit: BoxFit.contain, // Adjust the image to fit the circle
            ),
            _divider(),

            // About
            _sectionTitle('About'),
            _sectionContent(
                'Amrit Science Campus (ASCOL), situated in the heart of Kathmandu Valley, is the unique science campus of the country. Some of the finest technical manpower, who are now involved in different development activities both at home and abroad, were students of Amrit Campus. The Campus is a semi-autonomous institution under the Institute of Science and Technology with partial decentralization, affiliated to Tribhuvan University.\n\n'
                    'Amrit Science Campus offers courses in Physics, Chemistry, Mathematics, Botany, Zoology, Statistics, Computer Science, Environment Science, and Microbiology at the Bachelor\'s level. At present, nearly 1900 students are studying at different levels.'
            ),
            _divider(),

            // Vision
            _sectionTitle('Vision'),
            _sectionContent(
                '• To develop skilled and highly competent human resources in the field of Science and technology.\n'
                    '• To improve the existing classroom facilities for quality education.\n'
                    '• To upgrade the existing infrastructure facilities for the implementation of new programs.\n'
                    '• To enhance scientific research activities for human resource development.\n'
                    '• To establish a research-oriented education system up to the Ph.D. level and to promote all the departments as the “Center for Excellence”.'
            ),
            _divider(),

            // Mission
            _sectionTitle('Mission'),
            _sectionContent(
                '• To introduce Master level courses in some subjects like Botany, Chemistry, Zoology, Microbiology, and CSIT.\n'
                    '• To construct new infrastructure for introducing the above-mentioned Master level programs.\n'
                    '• To create a healthy teaching/learning environment and develop students who can think critically, communicate effectively, and be marketable in the global market.\n'
                    '• To renovate and upgrade the classroom and laboratory facilities with LCD projectors and internet facilities for updated knowledge sharing.'
            ),
            _divider(),

            // Values
            _sectionTitle('Values'),
            _sectionContent(
                '• Quality\n'
                    '• Creativity and Innovation\n'
                    '• Commitment\n'
                    '• Teamwork\n'
                    '• Compassion\n'
                    '• Integrity\n'
                    '• Diversity\n'
                    '• Professionalism'
            ),
            _divider(),

            // Salient Features
            _sectionTitle('Salient Features'),
            _sectionContent(
                'Amrit Campus library is imagined primarily as a reference library that will serve the needs of students, teachers, science researchers, and other professionals. This is the library for students who enroll at Amrit Campus. As part of the specialized collection on science and technology, books and many other types of reference materials (e.g., theses, journals, project reports) needed for research also receive high priority in the library’s holdings.\n\n'
                    'The library’s current holdings total more than 32,000 books, theses, and reports. More than 20 thousand books from the Intermediate level of Tribhuvan University, which was phased out in 2065 B.S., are to be weeded out soon. It holds several contemporary magazines and newspapers. Daily newspapers are collected and open to all for reading. Online resources include full-text INASP packages & Research4life packages (AGORA, ARDI, GOALI, Hinari, OARE) which can also be accessed for free.'
            ),
            _divider(),

            // Admission Guidelines
            _sectionTitle('Admission Guidelines'),
            _sectionContent(
                'To enroll in any B.Sc. programs being offered at Amrit Science Campus (ASCOL), applicants must fulfill the following criteria:\n\n'
                    '1. Those students who have graduated from the TU I.Sc. program or equivalent can apply.\n'
                    '2. All applicants must fill out the application form provided by the college.\n'
                    '3. All applicants must attach a copy of the I.Sc. or equivalent transcript as well as their School Leaving Certificate Mark-Sheet.\n\n'
                    'A notice, along with further information, will be published whenever the college invites applicants for admission.'
            ),
            _divider(),

            // Offered Programs
            _sectionTitle('Offered Programs - Tribhuvan University'),
            _sectionContent(
                '• BSc Computer Science and Information Technology (BSc CSIT) - 144 Seats\n'
                    '• MSc Physics - 60 Seats\n'
                    '• BSc Environmental Science\n'
                    '• BSc Microbiology - 60 Seats\n'
                    '• BSc Physics\n'
                    '• MSc in Mathematics - 60 Seats\n'
                    '• MSc in Botany - 24 Seats\n'
                    '• MSc Chemistry - 45 Seats\n'
                    '• Bachelors in Information Technology (BIT) - 36 Seats\n'
                    '• BSc Botany\n'
                    '• BSc Chemistry\n'
                    '• BSc Mathematics\n'
                    '• BSc Statistics\n'
                    '• BSc Zoology\n'
                    '• MSc Zoology - 24 Seats\n'
                    '• Master of Information Technology (MIT) - 30 Seats'
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _sectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        content,
        style: const TextStyle(
          fontSize: 16.0,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      height: 32.0,
      thickness: 1.0,
      color: Colors.grey,
    );
  }
}
