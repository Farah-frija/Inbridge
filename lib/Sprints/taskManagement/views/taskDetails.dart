import 'package:flutter/material.dart';

class TaskDetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task Title Example',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Additional Info:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'This is some additional information about the task.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Created At: January 1, 2022',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Updated At: January 2, 2022',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Deadline: January 10, 2022',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

class TaskDetailsBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TaskDetailsWidget(),
          SizedBox(height: 20.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
              },
              child: Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}

void showTaskDetailsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled:
        true, // Ensure the bottom sheet can be scrolled if it exceeds the screen height
    builder: (BuildContext context) {
      return TaskDetailsBottomSheet();
    },
  );
}
