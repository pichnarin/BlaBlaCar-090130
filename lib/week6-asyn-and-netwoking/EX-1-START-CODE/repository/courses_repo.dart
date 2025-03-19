import 'package:untitled/week6-asyn-and-netwoking/EX-1-START-CODE/models/course.dart';

abstract class CourseRepo {
  List<Course> get getCourses;
  void addCourse(Course course, CourseScore score);
  // void removeCourse(String courseId);
  // void updateCourse(Course updatedCourse);
}
