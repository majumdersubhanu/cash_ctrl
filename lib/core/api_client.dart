import 'package:auto_route/auto_route.dart';
import 'package:cash_ctrl/core/extensions.dart';
import 'package:cash_ctrl/core/logger.dart';
import 'package:cash_ctrl/core/prefs.dart';
import 'package:cash_ctrl/injection/injection.dart';
import 'package:cash_ctrl/routing/app_router.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class APIClient {
  APIClient() {
    _initialize();
  }

  final Dio _dio = Dio();

  Dio _initialize() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {
          options.baseUrl = 'https://cashctrl.pythonanywhere.com';
          options.followRedirects = true;
          options.headers['Accept'] = "application/json";

          final user = getIt<AppPrefs>().authUser.getValue();

          if (user != null) {
            options.headers['Authorization'] = "Bearer ${user.authToken}";
          }

          logger.d(
              '${options.uri} ${options.queryParameters} ${options.headers} ${options.data}');

          return handler.next(options);
        },
        onResponse:
            (Response response, ResponseInterceptorHandler handler) async {
          return handler.next(response);
        },
        onError:
            (DioException dioError, ErrorInterceptorHandler handler) async {
          try {
            logger.w(
                "Error : ${dioError.requestOptions.uri.path} ${dioError.message} ");

            logger.w(
                "${dioError.requestOptions.uri.path} -> ${dioError.response?.data}");

            if (dioError.response?.data['detail'] == "Invalid token.") {
              _handleInvalidToken();
            }
          } catch (e, stackTrace) {
            logger.e("API Client Error : $e");
            logger.e("API Client Stack Trace : $stackTrace");
          }

          return handler.next(dioError);
        },
      ),
    );
    return _dio;
  }

  _handleInvalidToken() async {
    final router = AppRouter();

    final context = router.navigatorKey.currentContext;
    if (context != null) {
      if (router.current.name != LoginRoute.name) {
        logger.d("Clearing App Prefs");
        await getIt<AppPrefs>().clear();
        context.showSnackBar("Token has expired! Please re-login..");
        AutoRouter.of(context).pushAndPopUntil(
          LoginRoute(),
          predicate: (_) => false,
        );
      }
    }
  }

  //GET
  Future<Response> get(
    String path, {
    Map<String, dynamic>? query,
    String? subPath,
    bool showErrorToast = true,
    Options? options,
  }) {
    String reqPath = path;
    if (subPath != null) reqPath = path + subPath;
    reqPath = '$reqPath/';
    return _dio.get(
      reqPath,
      queryParameters: query,
      options: options ?? Options(extra: {'showErrorToast': showErrorToast}),
    );
  }

  //POST
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? subPath,
    bool showErrorToast = true,
  }) {
    String reqPath = path;
    if (subPath != null) reqPath = path + subPath;
    reqPath = '$reqPath/';
    return _dio.post(
      reqPath,
      data: data,
      queryParameters: query,
      options: Options(extra: {'showErrorToast': showErrorToast}),
    );
  }

  //PUT
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? subPath,
    bool showErrorToast = true,
  }) {
    String reqPath = path;
    if (subPath != null) reqPath = path + subPath;
    reqPath = '$reqPath/';
    return _dio.put(
      reqPath,
      data: data,
      queryParameters: query,
      options: Options(extra: {'showErrorToast': showErrorToast}),
    );
  }

  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? subPath,
    bool showErrorToast = true,
  }) {
    String reqPath = path;
    if (subPath != null) reqPath = path + subPath;
    reqPath = '$reqPath/';
    return _dio.patch(
      reqPath,
      data: data,
      queryParameters: query,
      options: Options(extra: {'showErrorToast': showErrorToast}),
    );
  }

  //DELETE
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? subPath,
    bool showErrorToast = true,
  }) {
    String reqPath = path;
    if (subPath != null) reqPath = path + subPath;
    reqPath = '$reqPath/';
    return _dio.delete(
      reqPath,
      data: data,
      queryParameters: query,
      options: Options(extra: {'showErrorToast': showErrorToast}),
    );
  }
}
