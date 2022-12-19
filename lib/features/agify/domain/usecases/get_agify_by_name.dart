import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/agify.dart';
import '../repositories/agify_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAgifyByName extends Usecase<Agify, Params>{
  final AgifyRepo agifyrepo;
  GetAgifyByName(this.agifyrepo);

  @override
  Future<Either<Failure, Agify>> call(Params params) async {
    return await agifyrepo.getAgifyByName(params.name);
  }
}

class Params extends Equatable{
  final String name;

  const Params(this.name);
  
  @override
  List<Object?> get props => [name];
}