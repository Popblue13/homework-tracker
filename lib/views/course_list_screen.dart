import 'package:flutter/material.dart';

import '../presenters/course_presenter.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final CoursePresenter presenter = CoursePresenter();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    await presenter.loadCourses();
    setState(() => _isLoading = false);
  }

  void _showAddCourseDialog() {
    String name = '';
    String? description;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Course'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Course Name'),
                onChanged: (value) => name = value,
              ), // TextField
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                ),
                onChanged: (value) => description = value,
              ), // TextField
            ],
          ), // Column
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ), // TextButton
            TextButton(
              onPressed: () async {
                if (name.trim().isNotEmpty) {
                  await presenter.addCourse(name.trim(), description);
                  setState(() {});
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ), // TextButton
          ],
        ); // AlertDialog
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final courses = presenter.courses;

    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return ListTile(
                  title: Text(course.name),
                  subtitle: course.description != null
                      ? Text(course.description!)
                      : null,
                ); // ListTile
              },
            ), // ListView.builder
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCourseDialog,
        child: const Icon(Icons.add),
      ), // FloatingActionButton
    ); // Scaffold
  }
}
