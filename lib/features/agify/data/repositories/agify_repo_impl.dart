import '../../../../core/network/network_info.dart';
import '../datasource/agify_local_data_source.dart';
import '../datasource/agify_remote_data_source.dart';

import '../../domain/entities/agify.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/agify_repo.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

class AgifyRepoImpl implements AgifyRepo {
  final AgifyRemoteDataSource remoteDataSource;
  final AgifyLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AgifyRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Agify>> getAgifyByName(String name) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAgify = await remoteDataSource.getAgifyByName(name);
        localDataSource.cacheAgify(remoteAgify);
        return Right(remoteAgify);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localAgify = await localDataSource.getLocalDataSource();
        return Right(localAgify);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
