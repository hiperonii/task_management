import 'package:data/dto/task_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'task_api_service.g.dart';

@RestApi()
abstract class TaskApiService {
  factory TaskApiService(Dio dio, {String baseUrl}) = _TaskApiService;

  @GET('/todo-list')
  Future<TaskResponse> getTodoList(
    @Query('offset') int pageNumber,
    @Query('limit') int pageSize,
    @Query('sortBy') String sort, //createdAt
    @Query('isAsc') bool isAsc, //true
    @Query('status') String status,
  );
}
