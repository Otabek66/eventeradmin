import 'package:eventeradmin/constants/color_const.dart';
import 'package:eventeradmin/screens/home/cubit/home_cubit.dart';
import 'package:eventeradmin/screens/home/state/home_state.dart';
import 'package:eventeradmin/screens/home/view/scan_qr_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        var cubit = HomeCubit();
        cubit.getHttp();
        return cubit;
      },
      child: myScaffold(context),
    );
  }

  Scaffold myScaffold(BuildContext context) {
    var data = context.watch<HomeCubit>();
    var dataFunction = context.read<HomeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
        backgroundColor: ColorsConst.kprimaryColor,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
         if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is HomeComplate) { 
            return QrView();
          } else {
            return Center(child: Text((state as HomeError).msg));
          }
        },
      ),
    );
  }
}
