

import 'package:flutter/cupertino.dart';
import 'package:untitled/week6-asyn-and-netwoking/EX-1-START-CODE/models/course.dart';

import '../repository/courses_repo.dart';

class CoursesProvider with ChangeNotifier {
  final CourseRepo _courseRepo;

  CoursesProvider(this._courseRepo);

  List<Course> getCourses() {
    return _courseRepo.getCourses;
  }

  void addCourse(Course course) {
    _courseRepo.getCourses.add(course);
    notifyListeners();
  }

  Course getCourseFor(String courseId) {
    return _courseRepo.getCourses.firstWhere((course) => course.id == courseId);
  }

  void addScore(String courseId, CourseScore score) {
    Course course = getCourseFor(courseId);
    course.addScore(score);
    notifyListeners();
  }
}
