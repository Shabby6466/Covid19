import 'package:covid_tracker/model/states_services.dart';
import 'package:covid_tracker/navigation/NavigationServices.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
final GetIt sl = GetIt.instance;

void setup() {

  locator.registerSingleton<NavigationService>(NavigationServiceImpl());

  sl.registerLazySingleton<StatesServices>(()=>StatesServices());
}
