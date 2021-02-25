import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:carcassonne/app_config.dart';

Dio createCarcassonneDioClient([BaseOptions options]) {
  Dio client = new Dio();
  client.options.baseUrl = AppConfig.apiUrl;
  client.options.headers = {
    'x-speed-string': 'New_spped_string',
    'x-api-version': AppConfig.apiVersion,
  };
  client.transformer = FlutterTransformer();
  return client;
}
