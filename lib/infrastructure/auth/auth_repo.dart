import 'package:cash_ctrl/core/api_client.dart';
import 'package:cash_ctrl/core/logger.dart';
import 'package:cash_ctrl/domain/auth/entity/auth_user.dart';
import 'package:cash_ctrl/domain/auth/imp_auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ImpAuthRepository)
class AuthRepository extends ImpAuthRepository {
  final APIClient apiClient;
  AuthRepository(this.apiClient);

  @override
  Future<Either<String, AuthUser>> login(Map<String, dynamic> data) async {
    try {
      final response = await apiClient.post('/auth/login', data: data);

      return Right(AuthUser.fromJson(response.data));
    } catch (e) {
      logger.e("Error during login: $e");

      String errorMessage = "Failed to Login";

      if (e is DioException) {
        errorMessage = e.response?.data["error"] ?? e.message;
      }
      return Left(errorMessage);
    }
  }

  @override
  Future<Either<String, AuthUser>> register(Map<String, dynamic> data) async {
    try {
      final response = await apiClient.post('/auth/register', data: data);

      return Right(AuthUser.fromJson(response.data));
    } catch (e) {
      logger.e("Error during register: $e");

      String errorMessage = "Failed to Register";

      if (e is DioException) {
        errorMessage = e.response?.data["error"] ?? e.message;
      }
      return Left(errorMessage);
    }
  }

  @override
  Future<Response> resetPassword(
      String username, String password, String confirmPassword) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}
