// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:clean_arch/core/error/failure.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/agify.dart';
import '../../domain/usecases/get_agify_by_name.dart';

part 'agify_event.dart';
part 'agify_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class AgifyBloc extends Bloc<AgifyEvent, AgifyState> {
  final GetAgifyByName getAgifyByName;

  AgifyBloc({
    required this.getAgifyByName,
  }) : super(AgifyInitial()) {
    on<AgifyByName>((event, emit) async {
      emit(AgifyLoading());

      final failureOrAgify = await getAgifyByName(Params(event.name));
      failureOrAgify.fold(
          (failure) => emit(AgifyError(_mapFailureToString(failure))),
          (agify) => emit(AgifyLoaded(agify)));
    });
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Umexpected error';
    }
  }
}
