import 'package:flutter/material.dart';

class PlanOverviewScreen extends StatelessWidget {
  const PlanOverviewScreen({required this.clientId, super.key});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Plan overview. ClientId: $clientId'));
  }
}
