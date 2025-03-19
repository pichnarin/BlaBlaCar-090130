import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../provider/courses_provider.dart';

const Color mainColor = Colors.blue;

class CourseScoreForm extends StatefulWidget {
  final String courseId;

  const CourseScoreForm({super.key, required this.courseId});

  @override
  CourseScoreFormState createState() => CourseScoreFormState();
}

class CourseScoreFormState extends State<CourseScoreForm> {
  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _studentScoreController = TextEditingController();

  @override
  void dispose() {
    _studentNameController.dispose();
    _studentScoreController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final studentName = _studentNameController.text.trim();
      final studentScore = double.parse(_studentScoreController.text);

      final score = CourseScore(studentName: studentName, studentScore: studentScore);

      Provider.of<CoursesProvider>(context, listen: false).addScore(widget.courseId, score);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('Add Score'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _studentNameController,
                decoration: const InputDecoration(labelText: 'Student Name'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a student name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _studentScoreController,
                decoration: const InputDecoration(labelText: 'Student Score'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submitForm(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a score';
                  }
                  final score = double.tryParse(value);
                  if (score == null) {
                    return 'Please enter a valid number';
                  }
                  if (score < 0 || score > 100) {
                    return 'Score must be between 0 and 100';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text('Add Score', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
