import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../setting/cubit/setting_cubit.dart';
import '../../../setting/cubit/setting_state.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الشروط والأحكام',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [

          BlocConsumer<SettingCubit,SettingState>(builder: (context,state){
            return
              (state is SettingUpdate )?Text('${context.read<SettingCubit>().setting?.termsCondition?.ar?.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'),'')}'):
              (state is SettingLoading )?CircularProgressIndicator():SizedBox()
            ;

          }, listener: (context,state){}
          )
        ],
      ),

    );
  }
}