import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart' hide ImageSource;
import 'package:hawiah_driver/features/layout/presentation/screens/layout-screen.dart';
import 'package:hawiah_driver/features/location/service/location_service.dart';
import 'package:hawiah_driver/features/order/presentation/order-cubit/order-cubit.dart';
import 'package:hawiah_driver/features/order/presentation/order-cubit/order-state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import '../../../../core/custom_widgets/global-elevated-button-widget.dart';
import '../../../../core/images/app_images.dart';
class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key,required this.otp,required this.id});
final otp;
final id;
  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    super.initState();
  }
  getLocation()async{
    location=await LocationService().getCurrentLocation();
  }
 XFile? image;
 LocationData? location;
 bool? loading;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: BlocConsumer<OrderCubit,OrderState>(builder: (context,state){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [


              (image!=null)?Image.file(File(image!.path),height: 480.w,width: 450.w,):Column(
                children: [
                  InkWell(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black,width: 5.h)
                        ),
                        child: Image.asset(AppImages.carPickerIcon,height: 150.h,width: 200.w,fit: BoxFit.fill,)),
                    onTap: ()async{
                      image=await ImagePicker().pickImage(source:ImageSource.camera );
                      setState(() {

                      });
                    },

                  ),
                  SizedBox(height: 10.h,),
                  Text('ارفق صورة الحاوية'),
                ],
              ),
              SizedBox(height: 50.h,),
              Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child:(loading!=true)?
                GlobalElevatedButton(
                  label: "تاكيد الطلب",
                  onPressed: () {
                    if(location==null||image==null){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              elevation: 50,
                              backgroundColor: Colors.red,
                              content: Center(child: Text('please check your data and try again',style: TextStyle(fontSize: 18),)))
                      )
                      ;
                    }
                    else{
                      context.read<OrderCubit>().confirmOrders(orderId:widget.id,otp:  widget.otp,lat:  location!.latitude,long:location!.longitude,img: File(image!.path) );

                    }
                  },
                  backgroundColor: Color(0xff1A3C98),
                  textColor: Colors.white,
                  padding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  borderRadius: BorderRadius.circular(10),
                  fixedWidth: 0.95, // 80% of the screen width
                ):CircularProgressIndicator(),
              ),

            ],
          );
        }, listener: (BuildContext context, state) {
          if(state is OrderConfirmed){
            loading=false;
            showDialog(context: context, builder: (context)=>AlertDialog(
              content: Container(
                height: 150.h,
                width: 200.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(AppImages.confirmed,height: 40.h,),
                    Text('تم التأكيد بنجاح'),
                    GlobalElevatedButton(
                      label: "موافق",
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LayoutScreen()), (route) => false,);
                      },
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      borderRadius: BorderRadius.circular(10),
                      fixedWidth: 0.35, // 80% of the screen width
                    )

                  ],
                ),
              ),
            ));

          }else if(state is OrderError){
            showDialog(context: context, builder: (context)=>AlertDialog(
              content: Container(
                height: 150.h,
                width: 200.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(AppImages.error,height: 40.h,),
                    Text('تاكد من البيانات واعد المحاولة'),
                    GlobalElevatedButton(
                      label: "موافق",
                      onPressed: () {
                       Navigator.pop(context);
                       Navigator.pop(context);
                       Navigator.pop(context);
                      },
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      borderRadius: BorderRadius.circular(10),
                      fixedWidth: 0.35, // 80% of the screen width
                    )

                  ],
                ),
              ),
            ));
            loading=false;

          }else if(state is OrderLoading){
            loading=true;
          }else{
            loading= false;
          }
          
        }),
      ),
    );
  }
}
