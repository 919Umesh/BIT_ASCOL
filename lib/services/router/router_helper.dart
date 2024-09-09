import 'package:bit_ascol/screens/quiz/quizScreen.dart';
import 'package:bit_ascol/services/router/router_name.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../screens/Home/syllabus/s_semster.dart';
import '../../screens/artificail_Intelligence/chat_Screen.dart';
import '../../screens/assignment/display_assignment.dart';
import '../../screens/noteScreen/note_screen.dart';
import '../../screens/noteScreen/semester_List.dart';
import '../../screens/result/display_result.dart';
import '../../screens/student_list/student_list.dart';
import '../../screens/upcoming_events/view_event.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case notesScreenPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child:  NotesScreen(),
        );
        case assignmentPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child:  const AssignmentList(),
        );
        case resultPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child:  const ResultList(),
        );
        case studentListPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child:  const StudentList(),
        );
        case upcomingEventPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child:  const UpcomingEvent(),
        );
        case chatScreenPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child:  ChatScreen(),
        );

      default:
        return errorRoute();
    }
  }
  static Route<dynamic> errorRoute() {
    return PageTransition(
      type: PageTransitionType.rightToLeft,
      child: Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('ERROR ROUTE')),
      ),
    );
  }
}
