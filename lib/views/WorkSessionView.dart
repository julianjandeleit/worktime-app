import 'package:flutter/material.dart';
import 'package:work_time_app/viewmodels/WorkSessionViewModel.dart'; // Adjust the import path as needed
// Adjust the import path as needed
// Adjust the import path as needed

class WorkSessionView extends StatelessWidget {
  final WorkSessionViewModel workSessionViewModel; // Add this line

  const WorkSessionView({super.key, required this.workSessionViewModel}); // Add this constructor

  @override
  Widget build(BuildContext context) {
    final selectedProject = workSessionViewModel.selectedProject;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Work Sessions for ${selectedProject?.name ?? ''}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: workSessionViewModel.workSessions.length,
            itemBuilder: (context, index) {
              final workSession = workSessionViewModel.workSessions[index];
              return ListTile(
                title: Text('Start Time: ${workSession.startTime}'),
                subtitle: Text('End Time: ${workSession.endTime}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
