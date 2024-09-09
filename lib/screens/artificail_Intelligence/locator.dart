

import 'package:get_it/get_it.dart';

import 'chat_ViewModel.dart';
import 'gemini_repo.dart';

final locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => GeminiRepository());
  locator.registerLazySingleton(() => ChatViewModel());
}
