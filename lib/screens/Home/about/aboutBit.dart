import 'package:flutter/material.dart';

class AboutBIT extends StatelessWidget {
  const AboutBIT({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bachelor in Information Technology (BIT)'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction
            _sectionTitle('Bachelor in Information Technology (BIT)'),
            _sectionContent(
                'The Bachelor in Information Technology (BIT) is a 4-year (semester-based) course run by Tribhuvan University (TU)\'s Institute of Science and Technology (IOST). This course is modeled after the courses taught at authorized foreign universities. It includes foundation and core IT courses as well as optional courses to meet the demands of new technology development and implementation.\n\n'
                    'Students must complete 120 credit hours in various IT and related courses and have opportunities in software development, information security, database administration, network and system administration, and more.'
            ),
            _divider(),

            // Objective
            _sectionTitle('Objective'),
            _sectionContent(
                'The primary objective of the BIT program is to provide students with extensive knowledge and skills in the design, development, and application of information technology in various fields. Graduates are expected to have the essential IT understanding to compete in today\'s global environment.'
            ),
            _divider(),

            // Eligibility
            _sectionTitle('Eligibility'),
            _sectionContent(
                '• Completed a twelve-year education in any field or equivalent from a recognized institution.\n'
                    '• At least a second division in +2 or equivalent OR a ‘C’ grade or CGPA 2.0 in Class 11 and 12 with English and Mathematics.\n'
                    '• Passed A level with at least a ‘D’ in English and Mathematics.\n'
                    '• Completed a 3 Year Diploma in Engineering with English and Mathematics from CTEVT.\n'
                    '• Candidates with NG in at least two topics in 12th or equivalent can apply for the BIT entrance examination.'
            ),
            _divider(),

            // Courses Structure
            _sectionTitle('Courses Structure'),
            _courseTable(
              title: 'First Year - First Semester',
              courses: [
                'Introduction to IT',
                'C Programming',
                'Digital Logic',
                'Basic Mathematics',
                'Sociology'
              ],
              creditHours: '3',
              fullMarks: '100',
            ),
            _courseTable(
              title: 'First Year - Second Semester',
              courses: [
                'Microprocessor and Computer Architecture',
                'Discrete Structure',
                'Object Oriented Programming',
                'Basic Statistics',
                'Economics'
              ],
              creditHours: '3',
              fullMarks: '100',
            ),
            _courseTable(
              title: 'Second Year - Third Semester',
              courses: [
                'Data Structures and Algorithms',
                'Database Management System',
                'Numerical Methods',
                'Operating Systems',
                'Principles of Management'
              ],
              creditHours: '3',
              fullMarks: '100',
            ),
            _courseTable(
              title: 'Second Year - Fourth Semester',
              courses: [
                'Web Technology I',
                'Artificial Intelligence',
                'Systems Analysis and Design',
                'Network and Data Communications',
                'Operations Research'
              ],
              creditHours: '3',
              fullMarks: '100',
            ),
            _courseTable(
              title: 'Third Year - Fifth Semester',
              courses: [
                'Web Technology II',
                'Software Engineering',
                'Information Security',
                'Computer Graphics',
                'Technical Writing'
              ],
              creditHours: '3',
              fullMarks: '100',
            ),
            _courseTable(
              title: 'Third Year - Sixth Semester',
              courses: [
                'NET Centric Computing',
                'Database Administration',
                'Management Information System',
                'Research Methodology',
                'Elective I'
              ],
              creditHours: '3',
              fullMarks: '100',
            ),
            _courseTable(
              title: 'Fourth Year - Seventh Semester',
              courses: [
                'Advanced Java Programming',
                'Software Project Management',
                'E-commerce',
                'Project Work',
                'Elective II'
              ],
              creditHours: '3',
              fullMarks: '100',
            ),
            _courseTable(
              title: 'Fourth Year - Eighth Semester',
              courses: [
                'Network and System Administration',
                'E-Governance',
                'Internship',
                'Elective III'
              ],
              creditHours: '3',
              fullMarks: '100',
            ),
            _divider(),

            // Grading System
            _sectionTitle('Grading System'),
            _sectionContent(
                '• **A**: 90-100 (Outstanding)\n'
                    '• **A-**: 80-89 (Excellent)\n'
                    '• **B+**: 70-79 (Very Good)\n'
                    '• **B**: 60-69 (Good)\n'
                    '• **B-**: 50-59 (Satisfactory)\n'
                    '• **C**: 40-49 (Pass)\n'
                    '• **F**: 0-39 (Fail)\n'
                    'Grades are determined based on internal and external evaluations. The SGPA and CGPA are computed to assess overall performance.'
            ),
            _divider(),

            // Fee Structure
            _sectionTitle('Fee Structure'),
            _sectionContent(
                '• **TU BIT**: NPR 3.5 Lakhs\n'
                    'The fee structure is similar across all constituent colleges of Tribhuvan University.'
            ),
            _divider(),

            // Scope / Job Aspects
            _sectionTitle('Scope / Job Aspects'),
            _sectionContent(
                'Graduates can work in various fields such as:\n'
                    '• IT Consultant\n'
                    '• Software Developer\n'
                    '• Data Analyst\n'
                    '• Project Manager\n'
                    '• Systems Analyst\n'
                    '• Business Analyst\n'
                    '• E-commerce Manager\n'
                    '• Database Administrator\n'
                    '• Network Administrator\n'
                    '• Entrepreneurship\n'
                    '• Data Scientist\n'
                    '• Information Security Analyst\n'
                    '• UX Designer\n'
                    '• Business Intelligence Analyst'
            ),
            _sectionTitle('Colleges Offering BIT'),
            _collegesTable(),
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

  Widget _courseTable({
    required String title,
    required List<String> courses,
    required String creditHours,
    required String fullMarks,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(title),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Course')),
              DataColumn(label: Text('Credit Hours')),
              DataColumn(label: Text('Full Marks')),
            ],
            rows: courses
                .map(
                  (course) => DataRow(
                cells: [
                  DataCell(Text(course)),
                  DataCell(Text(creditHours)),
                  DataCell(Text(fullMarks)),
                ],
              ),
            )
                .toList(),
          ),
        ),
        _divider(),
      ],
    );
  }

  Widget _collegesTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('College Name')),
        DataColumn(label: Text('Location')),
      ],
      rows: const [
        DataRow(cells: [
          DataCell(Text('Amrit Science Campus (ASCOL)')),
          DataCell(Text('Lainchaur, Kathmandu')),
        ]),
        DataRow(cells: [
          DataCell(Text('Patan Multiple Campus')),
          DataCell(Text('Patan Dhoka, Lalitpur')),
        ]),
        DataRow(cells: [
          DataCell(Text('Bhaktapur Multiple Campus')),
          DataCell(Text('Doodhpati, Bhaktapur')),
        ]),
        DataRow(cells: [
          DataCell(Text('Padma Kanya Multiple Campus')),
          DataCell(Text('Bagbazar, Kathmandu')),
        ]),
        DataRow(cells: [
          DataCell(Text('Birendra Multiple Campus')),
          DataCell(Text('Bharatpur, Chitwan')),
        ]),
        DataRow(cells: [
          DataCell(Text('Mahendra Multiple Campus')),
          DataCell(Text('Nepalgunj, Banke')),
        ]),
        DataRow(cells: [
          DataCell(Text('Thakur Ram Multiple Campus')),
          DataCell(Text('Birgunj, Parsa')),
        ]),
        DataRow(cells: [
          DataCell(Text('Bhairahawa Multiple Campus')),
          DataCell(Text('Siddharthanagar, Rupandehi')),
        ]),
        DataRow(cells: [
          DataCell(Text('Ramsworup Ramsagar Multiple Campus')),
          DataCell(Text('Janakpur, Dhanusha')),
        ]),
        DataRow(cells: [
          DataCell(Text('Siddhanath Science Campus')),
          DataCell(Text('Bhimdatta, Kanchanpur')),
        ]),
        DataRow(cells: [
          DataCell(Text('Central Campus of Technology')),
          DataCell(Text('Dharan, Sunsari')),
        ]),
        DataRow(cells: [
          DataCell(Text('Mahendra Morang Adarsha Multiple Campus')),
          DataCell(Text('Biratnagar, Morang')),
        ]),
      ],
    );
  }
}
