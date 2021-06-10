import 'package:dio/dio.dart';

class ServerUrl{

static String url = 'http://192.168.1.110:3000' ;


static Dio dio = Dio(
  BaseOptions(
   baseUrl: url,
   receiveTimeout: 4000,
   connectTimeout: 5000,
   sendTimeout: 5000
));

}