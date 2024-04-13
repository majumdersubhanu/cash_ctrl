// Package imports:
import 'package:cash_ctrl/core/api_client.dart';
import 'package:cash_ctrl/domain/user/entity/user.dart';
import 'package:cash_ctrl/domain/user/imp_user_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ImpUserRepository)
class UserRepository extends ImpUserRepository {
  final APIClient apiClient;

  UserRepository(this.apiClient);

  @override
  Future<Either<String, User>> update(Map<String, dynamic> data) async {
    try {
      final response = await apiClient.put('/auth/user/update', data: data);

      final user = User.fromJson(response.data);

      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
