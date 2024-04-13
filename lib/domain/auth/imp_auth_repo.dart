import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'entity/auth_user.dart';

abstract class ImpAuthRepository {
  Future<Either<String, AuthUser>> login(Map<String, dynamic> data);

  Future<Response> resetPassword(
      String username, String password, String confirmPassword);

  Future<Either<String, AuthUser>> register(Map<String, dynamic> data);
}
