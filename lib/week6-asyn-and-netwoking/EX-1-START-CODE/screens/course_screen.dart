import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../provider/courses_provider.dart';
import 'course_score_form.dart';

class CourseScreen extends StatelessWidget {
  final Course course;

  const CourseScreen({super.key, required this.course});

  void _addScore(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => CourseScoreForm(courseId: course.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scores:', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),

            Expanded(
              child: Consumer<CoursesProvider>(
                builder: (context, coursesProvider, _) {
                  final updatedCourse = coursesProvider.getCourseFor(course.id);

                  if (updatedCourse.scores.isEmpty) {
                    return const Center(
                      child: Text(
                        'No scores yet',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: updatedCourse.scores.length,
                    itemBuilder: (ctx, index) {
                      final score = updatedCourse.scores[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(score.studentName, style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text(
                            score.studentScore.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => _addScore(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text('Add Score'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
