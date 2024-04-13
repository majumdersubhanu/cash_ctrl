import 'package:cash_ctrl/core/logger.dart';
import 'package:cash_ctrl/domain/auth/entity/auth_user.dart';
import 'package:cash_ctrl/domain/user/entity/user.dart';
import 'package:cash_ctrl/injection/injection.dart';
import 'package:cash_ctrl/routing/app_router.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class AppPrefs {
  final StreamingSharedPreferences preferences;

  AppPrefs(
    this.preferences,
  )   : authToken = preferences.getString(
          PrefsConstants.authToken,
          defaultValue: "",
        ),
        userId = preferences.getInt(
          PrefsConstants.userId,
          defaultValue: -1,
        ),
        currentUser = preferences.getCustomValue(
          PrefsConstants.currUser,
          defaultValue: null,
          adapter: JsonAdapter(
            deserializer: (val) => User.fromJson(
              val as Map<String, dynamic>,
            ),
          ),
        ),
        authUser = preferences.getCustomValue(
          PrefsConstants.authUser,
          defaultValue: null,
          adapter: JsonAdapter(
            deserializer: (val) => AuthUser.fromJson(
              val as Map<String, dynamic>,
            ),
          ),
        );

  final Preference<String> authToken;
  final Preference<int> userId;
  final Preference<AuthUser?> authUser;
  final Preference<User?> currentUser;

  Future<bool> setBool(String key, {required bool value}) async {
    printBefore(value: value, key: key);
    return preferences.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    printBefore(value: value, key: key);
    return preferences.setDouble(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    printBefore(value: value, key: key);
    return preferences.setInt(key, value);
  }

  Future<void> clear() async {
    await preferences.clear();
  }

  Future<bool> setString(String key, String value) async {
    printBefore(value: value, key: key);
    return preferences.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    printBefore(value: value, key: key);
    return preferences.setStringList(key, value);
  }

  Future<bool> setCustomValue(
      String key, value, PreferenceAdapter<dynamic> adapter) async {
    printBefore(value: value, key: key);
    return preferences.setCustomValue(key, value, adapter: adapter);
  }

  void printBefore({String? key, value}) =>
      logger.w('Saving Key: $key &  value: $value');
}

class PrefsConstants {
  static const String authToken = "authToken";
  static const String userId = 'userId';
  static const String authUser = 'authUser';
  static const String currUser = 'currUser';
}

/// Making AppPrefs injectable
Future<void> setupLocator() async {
  final preferences = await StreamingSharedPreferences.instance;
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<AppPrefs>(() => AppPrefs(preferences));
}
