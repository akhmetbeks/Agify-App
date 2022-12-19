part of 'agify_bloc.dart';

abstract class AgifyEvent extends Equatable {
  const AgifyEvent();

  @override
  List<Object> get props => [];
}

class AgifyByName extends AgifyEvent {
  final String name;

  const AgifyByName({required this.name});
}
