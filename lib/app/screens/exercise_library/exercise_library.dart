import 'package:flutter/material.dart';

class ExerciseLibraryScreen extends StatelessWidget {
  const ExerciseLibraryScreen({required this.clientId, super.key});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Exercise library! Finally! $clientId'),
      // child: Text('Exercise library! Finally!'),
    );
  }
}
