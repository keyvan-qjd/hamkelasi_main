import 'dart:developer';

import 'package:dio/dio.dart';

class DioInceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('URL: ${options.uri}');
    log('HEADERS: ${options.headers}');
    log('BODY: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('STATUS CODE: ${response.statusCode}');
    log('DATA: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('ERROR: ${err.message} kos');
    handler.next(err);
  }
}
