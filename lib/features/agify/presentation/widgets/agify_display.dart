import 'package:flutter/material.dart';

import '../../domain/entities/agify.dart';

class AgifyDisplay extends StatelessWidget {
  final Agify agify;
  const AgifyDisplay({
    required this.agify,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(agify.name),
          Center(
            child: Text(agify.age.toString()),
          ),
        ],
      ),
    );
  }
}
