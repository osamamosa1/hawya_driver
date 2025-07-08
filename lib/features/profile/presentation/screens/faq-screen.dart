import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../setting/cubit/setting_cubit.dart';
import '../../../setting/cubit/setting_state.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الاسئلة الشائعة',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [

          BlocConsumer<SettingCubit,SettingState>(builder: (context,state){
            return (state is SettingUpdate )?Column(
              children: [
                Text('${context.read<SettingCubit>().setting?.faqTitle?.ar?.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'),'')}'),
                Text('${context.read<SettingCubit>().setting?.faqDescription?.ar?.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'),'')}'),
              ],
            ):
            (state is SettingLoading )?CircularProgressIndicator():SizedBox()

            ;

          }, listener: (context,state){}
          )
        ],
      ),

    );
  }
}
