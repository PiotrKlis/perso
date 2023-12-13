import 'package:flutter/material.dart';

// class EmptyScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => EmptyBloc(EmptyState.initial()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("empty screen"),
//         ),
//         body: EmptyScreenView(),
//       ),
//     );
//   }
// }

class EmptyScreenView extends StatelessWidget {
  const EmptyScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
