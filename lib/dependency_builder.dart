import 'package:data/api_service_provider.dart';
import 'package:data/task_api_service.dart';
import 'package:get_it/get_it.dart';
import 'package:task_management/service/navigation/navigation_service.dart';

final GetIt locator = GetIt.instance;

class DependencyBuilder {
  void build() {
    // Build Service
    locator.registerLazySingleton<NavigationService>(() => NavigationService());

    // Build ApiService
    final apiServiceProvider = ApiServiceProvider();
    locator.registerLazySingleton<TaskApiService>(() => apiServiceProvider.taskApiService);
  }
}
