import 'package:cash_ctrl/domain/user/entity/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    @JsonKey(name: 'user') required User user,
    @JsonKey(name: 'access') required String authToken,
    @JsonKey(name: 'refresh') required String refreshToken,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}
