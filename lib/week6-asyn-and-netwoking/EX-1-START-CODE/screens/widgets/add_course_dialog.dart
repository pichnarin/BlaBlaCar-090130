import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../models/course.dart';

import '../../provider/courses_provider.dart';

class AddCourseDialog extends StatefulWidget {
  const AddCourseDialog({super.key});

  @override
  AddCourseDialogState createState() => AddCourseDialogState();
}

class AddCourseDialogState extends State<AddCourseDialog> {
  final _formKey = GlobalKey<FormState>();
  final _courseNameController = TextEditingController();
  final _uuid = const Uuid();

  void _submitCourse() {
    if (_formKey.currentState!.validate()) {
      final courseName = _courseNameController.text;
      final newCourse = Course(id: _uuid.v4(), name: courseName, scores: []);

      Provider.of<CoursesProvider>(context, listen: false).addCourse(newCourse);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add New Course"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _courseNameController,
          decoration: const InputDecoration(labelText: "Course Name"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a course name.";
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _submitCourse,
          child: const Text("Add Course"),
        ),
      ],
    );
  }
}
