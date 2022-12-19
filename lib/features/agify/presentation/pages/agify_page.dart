import 'package:clean_arch/features/agify/presentation/bloc/agify_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/agify_conroller.dart';
import '../widgets/agify_display.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';

import '../../../../injection_container.dart';

class AgifyPage extends StatelessWidget {
  const AgifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agify'),
      ),
      body: SingleChildScrollView(
        child: buildbody(context),
      ),
    );
  }

  BlocProvider<AgifyBloc> buildbody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AgifyBloc>(),
      child: Column(
        children: [
          BlocBuilder<AgifyBloc, AgifyState>(
            builder: (context, state) {
              if (state is AgifyInitial) {
                return const MessageDisplay(
                  message: 'Start Agify!',
                );
              } else if (state is AgifyLoading) {
                return const LoadingWidget();
              } else if (state is AgifyLoaded) {
                return AgifyDisplay(agify: state.agify);
              } else if (state is AgifyError) {
                return MessageDisplay(message: state.message);
              } else {
                return Container();
              }
            },
          ),
          const AgifyControls()
        ],
      ),
    );
  }
}
