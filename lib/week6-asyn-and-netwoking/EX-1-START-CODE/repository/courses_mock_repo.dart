import 'package:untitled/week6-asyn-and-netwoking/EX-1-START-CODE/repository/courses_repo.dart';
import 'package:untitled/week6-asyn-and-netwoking/EX-1-START-CODE/models/course.dart';

class CourseMockRepo extends CourseRepo {
  final List<Course> _courses = [];

  @override
  List<Course> get getCourses => _courses;

  @override
  void addCourse(Course course, CourseScore score) {
    course.addScore(score);
    _courses.add(course);
  }
}
