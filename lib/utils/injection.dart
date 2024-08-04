import 'package:covid_tracker/model/states_services.dart';
import 'package:covid_tracker/navigation/NavigationServices.dart';
import 'package:covid_tracker/utils/theme_notifier.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setup() {
  locator.registerSingleton<NavigationService>(NavigationServiceImpl());
  locator.registerLazySingleton<StatesServices>(() => StatesServices());
  locator.registerLazySingleton<ThemeNotifier>(() => ThemeNotifier());
}
