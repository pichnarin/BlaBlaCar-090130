import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/week6-asyn-and-netwoking/EX-1-START-CODE/screens/widgets/add_course_dialog.dart';
import '../models/course.dart';
import '../provider/courses_provider.dart';
import 'course_screen.dart';


const Color mainColor = Colors.blue;

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  void _addNewCourse(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AddCourseDialog(),
    );
  }

  void _editCourse(BuildContext context, Course course) {
    Navigator.of(context).push<Course>(
      MaterialPageRoute(builder: (ctx) => CourseScreen(course: course)),
    ).then((_) {
      Provider.of<CoursesProvider>(context, listen: false).notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    final coursesProvider = Provider.of<CoursesProvider>(context);
    final courses = coursesProvider.getCourses();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('SCORE APP', style: TextStyle(color: Colors.white)),
      ),
      body: courses.isEmpty
          ? const Center(child: Text("No courses available. Add one!"))
          : ListView.builder(
              itemCount: courses.length,
              itemBuilder: (ctx, index) {
                final course = courses[index];
                return CourseTile(
                  course: course,
                  onEdit: (course) => _editCourse(context, course),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewCourse(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course, required this.onEdit});

  final Course course;
  final Function(Course) onEdit;

  int get numberOfScores => course.scores.length;

  String get numberText {
    return course.hasScore ? "$numberOfScores scores" : 'No score';
  }

  String get averageText {
    String average = course.average.toStringAsFixed(1);
    return course.hasScore ? "Average: $average" : '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: ListTile(
          onTap: () => onEdit(course),
          title: Text(course.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(numberText, style: TextStyle(color: Colors.grey[700])),
              Text(averageText, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
}

