import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://student.valuxapps.com/api/",
        connectTimeout: 5000,
        receiveTimeout: 3000,
      receiveDataWhenStatusError: true,
      headers: {
        'Content-Type':'application/json',
        //'lang':'en'
      }

    ));
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async
  {
    dio.options.headers =
    {
      'lang':lang,
      'Authorization': token??'',
      'Content-Type': 'application/json',
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }
  static Future<Response> postData(
      {@required String url,
      Map<String, dynamic> query,
      @required Map<String, dynamic> data,
      String lang,
      String token,
      }) async {
    dio.options.headers =
    {
      'lang':lang,
      'Authorization': token??'',
      'Content-Type': 'application/json',
    };

    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData(
      {@required String url,
        Map<String, dynamic> query,
        @required Map<String, dynamic> data,
        String lang,
        String token,
      }) async {
    dio.options.headers =
    {
      'lang':lang,
      'Authorization': token??'',
      'Content-Type': 'application/json',
    };

    return await dio.put(url, queryParameters: query, data: data,);
  }


  static Future<Response> deleteData({
    @required String url,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async {
    return dio
        .delete(
      url,
    )
        .catchError((error) {
      print("DIO ERROR $error");
    });
  }
}

