import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/agify_bloc.dart';

class AgifyControls extends StatefulWidget {
  const AgifyControls({
    super.key,
  });

  @override
  State<AgifyControls> createState() => _AgifyControlsState();
}

class _AgifyControlsState extends State<AgifyControls> {
  final controller = TextEditingController();
  late String inputStr;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a name',
          ),
          onChanged: (value) {
            inputStr = value;
          },
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          child: Text('Search'),
          onPressed: dispatchAgify,
        ),
      ],
    );
  }

  void dispatchAgify() {
    controller.clear();
    BlocProvider.of<AgifyBloc>(context).add(AgifyByName(name: inputStr));
  }
}
