
import 'package:eventeradmin/screens/home/cubit/home_cubit.dart';
import 'package:eventeradmin/screens/home/view/changeable_page_view.dart';
import 'package:eventeradmin/screens/home/view/scan_qrw_view_without_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
void main() async{ 
  await GetStorage.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => HomeCubit()),
  ], child: const MyApp()));
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: ChangeablePage(),
    );
  }
}
