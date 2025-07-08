import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawiah_driver/features/profile/presentation/cubit/cubit_profile.dart';
import 'package:hawiah_driver/features/profile/presentation/cubit/state_profile.dart';
import 'package:hawiah_driver/features/setting/cubit/setting_cubit.dart';

import '../../../setting/cubit/setting_state.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "سياسة الخصوصية",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [

          BlocConsumer<SettingCubit,SettingState>(builder: (context,state){
            return
             (state is SettingUpdate )?Text('${context.read<SettingCubit>().setting?.privacy?.ar?.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'),'')}'):
             (state is SettingLoading )?CircularProgressIndicator():SizedBox()
            ;

          }, listener: (context,state){}
          )
        ],
      ),
    );
  }
}
