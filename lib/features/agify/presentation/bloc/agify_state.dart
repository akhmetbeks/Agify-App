part of 'agify_bloc.dart';

abstract class AgifyState extends Equatable {
  const AgifyState();

  @override
  List<Object> get props => [];
}

class AgifyInitial extends AgifyState {}

class AgifyLoading extends AgifyState {}

class AgifyLoaded extends AgifyState {
  final Agify agify;

  const AgifyLoaded(this.agify);
}

class AgifyError extends AgifyState {
  final String message;

  const AgifyError(this.message);
}
