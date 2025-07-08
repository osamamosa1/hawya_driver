
import 'package:hawiah_driver/injection_container.dart';

import 'presentation/order-cubit/order-cubit.dart';



class OrderInjection {
  static void init() {
    //cubit

     sl.registerFactory(() => OrderCubit());

    //use cases

    //repository

    //data sources
  }
}
