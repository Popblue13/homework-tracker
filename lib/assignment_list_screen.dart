import 'package:flutter/material.dart';

class AssignmentListScreen extends StatefulWidget {
  const AssignmentListScreen({super.key});

  @override
  State<AssignmentListScreen> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  final List<Map<String, dynamic>> _assignments = [];

  void _showAddAssignmentDialog() {
    String newAssignmentTitle = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Assignment'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter assignment title',
            ),
            onChanged: (value) {
              newAssignmentTitle = value;
            },
          ), // TextField
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cancel button
              child: const Text('Cancel'),
            ), // TextButton
            TextButton(
              onPressed: () {
                if (newAssignmentTitle.trim().isNotEmpty) {
                  setState(() {
                    _assignments.add({
                      'title': newAssignmentTitle.trim(),
                      'completed': false,
                    });
                  });
                }
                Navigator.pop(context); // Close dialog
              },
              child: const Text('Add'),
            ), // TextButton
          ],
        ); // AlertDialog
      },
    );
  }

  void _toggleCompleted(int index, bool? value) {
    setState(() {
      _assignments[index]['completed'] = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assignments')),
      body: ListView.builder(
        itemCount: _assignments.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              _assignments[index]['title'],
              style: TextStyle(
                decoration: _assignments[index]['completed']
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            value: _assignments[index]['completed'],
            onChanged: (value) => _toggleCompleted(index, value),
          ); // CheckboxListTile
        },
      ), // ListView.builder
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAssignmentDialog, // use the dialog function
        child: const Icon(Icons.add),
      ), // FloatingActionButton
    ); // Scaffold
  }
}
