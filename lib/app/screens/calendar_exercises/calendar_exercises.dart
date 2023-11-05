import 'package:flutter/material.dart';

class CalendarExercisesScreen extends StatelessWidget {
  const CalendarExercisesScreen({required this.clientId, super.key});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('CalendarExercisesScreen clientId: $clientId'));
  }
}
