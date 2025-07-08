
import 'package:hawiah_driver/features/location/presentation/cubit/address_cubit.dart';
import 'package:hawiah_driver/injection_container.dart';

class AddressInjection {
  static void init() {
    //cubit

    sl.registerFactory(() => AddressCubit());

    //use cases

    //repository

    //data sources
  }
}
