
import 'package:hawiah_driver/features/authentication/presentation/controllers/auth-cubit/auth-cubit.dart';
import 'package:hawiah_driver/injection_container.dart';



class AuthenticationInjection {
  static void init() {
    //cubit

    sl.registerFactory(() => AuthCubit());

    //use cases

    //repository

    //data sources
  }
}
