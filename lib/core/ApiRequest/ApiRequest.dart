import 'dart:developer';
import 'package:application/core/ApiRequest/Interceptor.dart';
import 'package:application/core/services/LocalStorage.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';// conflict Response Dio with Response Getx

class DioHelper {
  late dio.Dio _dio;
  var storage = Get.put<LocalStorageService>(LocalStorageService());
  
  DioHelper() {
        String sessionToken = storage.getCustomData(dotenv.env['SESSION_TOKEN_NAME']);
      log(sessionToken);
    _dio = dio.Dio(dio.BaseOptions(baseUrl:dotenv.env['APP_API_URL']!));
    _dio.interceptors.add(DioInceptor());
  if (sessionToken != null && sessionToken.isNotEmpty && sessionToken != '') {
      log('saved token');
      log(sessionToken);
      _dio.interceptors.add(dio.InterceptorsWrapper(
        onRequest: (options, handler) {
          // Safely add the session token to the request headers
          options.headers['Cookie'] = sessionToken;
          return handler.next(options);
        },
      ));
    }

  }

  Future<dio.Response> getRequest(String url,[data]) async {
    try {
      dio.Response response = await _dio.get(url,data: data ?? {});
      
      return response;
    } on dio.DioException catch (dioException) {
      return dioError(dioException);
    } catch (e) {
      print(e);
      return Future.error('یک خطای نامشخص رخ داده است');
    }
  }


   Future<dio.Response> postRequest(String url,data) async {
    try {
      dio.Response response = await _dio.post(url,data: data);
      return response;
    } on dio.DioException catch (dioException) {
      return dioError(dioException);
    } catch (e) {
      print(e);
      return Future.error('یک خطای نامشخص رخ داده است');
    }
  }
}

dioError(dioException) {
  switch (dioException.type) {
    case dio.DioExceptionType.cancel:
      return Future.error('درخواست لغو شد');
    case dio.DioExceptionType.cancel:
      return Future.error('زمان اتصال به سرور به پایان رسید');
    case dio.DioExceptionType.sendTimeout:
      return Future.error('زمان ارسال درخواست به پایان رسید');
    case dio.DioExceptionType.receiveTimeout:
      return Future.error('زمان دریافت پاسخ به پایان رسید');
    case dio.DioExceptionType.connectionTimeout:
      if (dioException.response != null) {
        print(
            'Received invalid status code: ${dioException.response!.statusCode}');
      }
      return Future.error('پاسخ نامعتبر از سرور دریافت شد');
    case dio.DioExceptionType.connectionError:
      return Future.error('یک خطای دیگر رخ داده است');
    default:
      return Future.error('خطا ناشناخته');
  }
}






