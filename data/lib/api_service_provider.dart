import 'package:data/api_service/task_api_service.dart';
import 'package:dio/dio.dart';

class ApiServiceProvider {
  late final Dio _dio = Dio();
  late final String _baseUrl = 'https://todo-list-api-mfchjooefq-as.a.run.app/';

  TaskApiService get taskApiService => TaskApiService(_dio, baseUrl: _baseUrl);
}
