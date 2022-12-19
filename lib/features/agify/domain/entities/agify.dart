import 'package:equatable/equatable.dart';

class Agify extends Equatable {
  final String name;
  final int age;
  const Agify({required this.age, required this.name});

  @override
  List<Object?> get props => [age, name];
}
