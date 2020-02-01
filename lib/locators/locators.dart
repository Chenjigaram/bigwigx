import 'package:bigwigx/services/book_service.dart';
import 'package:bigwigx/services/cart_service.dart';
import 'package:bigwigx/services/storage_service.dart';
import 'package:bigwigx/services/user_service.dart';
import 'package:bigwigx/utils/verify_connectivity.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt.asNewInstance();

void setUpObjects() {
  locator.registerLazySingleton(() => NetworkVerifier());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => BookService());
  locator.registerLazySingleton(() => CartService());
}