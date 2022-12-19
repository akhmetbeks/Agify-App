import '../../domain/entities/agify.dart';

class AgifyModel extends Agify {
  @override
  final String name;
  @override
  final int age;

  const AgifyModel({
    required this.name,
    required this.age,
  }) : super(age: age, name: name);

  factory AgifyModel.fromJson(Map<String, dynamic> json) {
    return AgifyModel(name: json['name'], age: json['age']);
  }

  Map<String, dynamic> toJson() {
    return {
      "age": age,
      "name": name,
    };
  }
}
