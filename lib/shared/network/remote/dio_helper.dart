// ignore_for_file: unused_field


import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: 
        {
          'Content-Type' : 'application/json'
        },
      ),
    );
  }
  
  static Future<Response> getData({
    required url ,
   Map<String ,dynamic>? query,
   String? token,
   String lang = 'en',
  }) async
  {
    dio.options.headers = 
    {
        'lang' : lang,
        'Content-Type' : 'application/json',
        'Authorization' : token??'',
    };
    return await dio.get(url , queryParameters: query,

    );
  }
  static Future<Response> PostData(
    {
    required url ,
     Map<String ,dynamic>? query,
    required Map<String ,dynamic> data,
    String lang = 'en',
    String? token
    }
  ) async
  {
    dio.options.headers = 
    {
        'lang' : lang,
        'Authorization' : token,
    };
    return await dio.post(url , 
    queryParameters: query,
    data: data);
  }
  static Future<Response> updateData(
    {
    required url ,
     Map<String ,dynamic>? query,
    required Map<String ,dynamic> data,
    String lang = 'en',
    String? token
    }
  ) async
  {
    dio.options.headers = 
    {
        'lang' : lang,
        'Authorization' : token,
    };
    return await dio.put(url , 
    queryParameters: query,
    data: data);
  }
}
