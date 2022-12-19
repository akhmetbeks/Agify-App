import 'dart:convert';

import '../../../../core/error/exception.dart';

import '../models/agify_model.dart';
import 'package:dio/dio.dart';

abstract class AgifyRemoteDataSource {
  /// Calls the https://api.agify.io/?name={name} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<AgifyModel> getAgifyByName(String name);
}

class AgifyRemoteDataSourceImpl implements AgifyRemoteDataSource {
  final Dio dio;

  AgifyRemoteDataSourceImpl(this.dio);
  @override
  Future<AgifyModel> getAgifyByName(String name) async {
    final response = await dio.get('https://api.agify.io/?name=$name');

    if (response.statusCode == 200) {
      // final ee = AgifyModel.fromJson(response.data);
      return AgifyModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
