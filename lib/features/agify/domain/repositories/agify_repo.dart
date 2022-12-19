import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/agify.dart';

abstract class AgifyRepo {
  Future<Either<Failure, Agify>> getAgifyByName(String name);
}