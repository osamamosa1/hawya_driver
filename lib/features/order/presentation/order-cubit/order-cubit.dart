import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hawiah_driver/core/locale/app_locale_key.dart';
import 'package:hawiah_driver/core/networking/api_helper.dart';
import 'package:hawiah_driver/core/networking/urls.dart';
import 'package:hawiah_driver/core/utils/common_methods.dart';
import 'package:hawiah_driver/core/utils/navigator_methods.dart';
import 'package:hawiah_driver/features/order/presentation/model/orders_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:table_calendar/table_calendar.dart';

import 'order-state.dart';

class OrderCubit extends Cubit<OrderState> {
  static OrderCubit get(BuildContext context) => BlocProvider.of(context);

  OrderCubit() : super(OrderInitial());

  changeRebuild() {
    emit(OrderChange());
  }

  bool isOrderCurrent = true;

  void changeOrderCurrent() {
    isOrderCurrent = !isOrderCurrent;
    emit(OrderChange());
  }

  CalendarFormat calendarFormat = CalendarFormat.month;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  DateTime? rangeStart;
  DateTime? rangeEnd;

  void initialOrders() {
    _ordersResponse = ApiResponse(state: ResponseState.sleep, data: null);
    _orders = null;
    emit(OrderChange());
  }

  ApiResponse _ordersResponse = ApiResponse(
    state: ResponseState.sleep,
    data: null,
  );

  ApiResponse get ordersResponse => _ordersResponse;

  OrdersModel? _orders;

  OrdersModel? get orders => _orders;

  Future<void> getOrders(int orderStatus) async {
    emit(OrderLoading());
    _ordersResponse = ApiResponse(state: ResponseState.loading, data: null);
    _orders = null;
    emit(OrderLoading());
    _ordersResponse = await ApiHelper.instance.get(Urls.orders(orderStatus));
    emit(OrderChange());

    if (_ordersResponse.state == ResponseState.complete) {
      _orders = OrdersModel.fromJson(_ordersResponse.data);
      emit(OrderSuccess(ordersModel: _orders));
    } else if (_ordersResponse.state == ResponseState.unauthorized) {
      emit(OrderError());
    }
  }
   compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = path.join(dir.absolute.path, 'compressed_${path.basename(file.path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50, // Adjust quality (0-100)
      format: CompressFormat.jpeg,
    );

    return result ?? file; // fallback to original if compression fails
  }

  Future<void> confirmOrders({
    required int orderId,
    required otp,
    required lat,
    required long,
    required File img,
  }) async {
    XFile imageFile=await compressImage(File(img.path));
    final data = <String, dynamic>{
      'otp': otp,
      'latitude': lat,
      'longitude': long,
    };
      data['hawiah_image'] = await MultipartFile.fromFile(
        imageFile.path,
        filename: "hawiah.jpg",
        contentType: DioMediaType('image','jpg')
      );


    final formData = FormData.fromMap(data);

    emit(OrderLoading());
    _ordersResponse = ApiResponse(state: ResponseState.loading, data: null);
    var _success = null;
    emit(OrderLoading());
    _ordersResponse = await ApiHelper.instance.post(
      Urls.confirmOrders(orderId),
      body: formData,
      hasToken: true,
      isMultipart: true,
    );
    emit(OrderChange());

    if (_ordersResponse.data['success']==true) {
      emit(OrderConfirmed(success: _success));
    } else  {
      emit(OrderError());
    }
  }

  //================== get nearby provider ====================

  Future<void> getNearbyProviders({
    required int catigoryId,
    required int addressId,
    required VoidCallback onSuccess,
  }) async {
    NavigatorMethods.loading();
    FormData body = FormData.fromMap({
      'product_id': catigoryId,
      'address_id': addressId,
    });
    final response = await ApiHelper.instance.post(
      Urls.getNearbyProviders,
      body: body,
    );
    NavigatorMethods.loadingOff();
    if (response.state == ResponseState.complete) {
      onSuccess.call();
    } else if (response.state == ResponseState.unauthorized) {
      CommonMethods.showAlertDialog(
        message: tr(AppLocaleKey.youMustLogInFirst),
      );
    } else {
      CommonMethods.showError(
        message: response.data['message'] ?? 'حدث خطاء',
        apiResponse: response,
      );
    }
  }
  //?================== create order ====================
}
