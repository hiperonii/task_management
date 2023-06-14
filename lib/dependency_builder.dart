import 'package:data/api_service/task_api_service.dart';
import 'package:data/api_service_provider.dart';
import 'package:data/repository/task_mapper.dart';
import 'package:data/repository/task_repository_impl.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/repository_provider.dart';
import 'package:presentation/service/navigation/navigation_service.dart';
import 'package:presentation/service/passcode/passcode_service.dart';
import 'package:task_management/repository_provider_impl.dart';

final GetIt locator = GetIt.instance;

class DependencyBuilder {
  void build() {
    // Build Service
    locator.registerLazySingleton<NavigationService>(() => NavigationService());
    locator.registerLazySingleton<PasscodeService>(() => PasscodeService());

    // Build ApiService
    final apiServiceProvider = ApiServiceProvider();
    locator.registerLazySingleton<TaskApiService>(() => apiServiceProvider.taskApiService);

    // Build Mapper
    locator.registerLazySingleton<TaskMapper>(() => TaskMapper());

    // Build Repository,
    repositoryProvider = RepositoryProviderImpl();

    locator.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(
          locator.get<TaskApiService>(),
          locator.get<TaskMapper>(),
        ));
  }
}
