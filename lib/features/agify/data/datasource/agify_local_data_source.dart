import 'dart:convert';

import '../../../../core/error/exception.dart';

import '../models/agify_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AgifyLocalDataSource {
  Future<AgifyModel> getLocalDataSource();

  Future<void> cacheAgify(AgifyModel agifyTocache);
}

class AgifyLocalDataSourceImpl implements AgifyLocalDataSource {
  final SharedPreferences sharedPreferences;

  AgifyLocalDataSourceImpl(this.sharedPreferences);

  static const CACHE_AGIFY = 'CACHE_AGIFY';

  @override
  Future<void> cacheAgify(AgifyModel agifyTocache) {
    return sharedPreferences.setString(
      CACHE_AGIFY,
      json.encode(agifyTocache.toJson()),
    );
  }

  @override
  Future<AgifyModel> getLocalDataSource() {
    final jsonString = sharedPreferences.getString(CACHE_AGIFY);

    if (jsonString != null) {
      return Future.value(AgifyModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
