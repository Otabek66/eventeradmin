import 'package:eventeradmin/screens/home/cubit/home_cubit.dart';
import 'package:eventeradmin/screens/home/state/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        var cubit = HomeCubit();
        cubit.getWebsiteData();
        return cubit;
      },
      child: myScaffold(context),
    );
  }

  Scaffold myScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
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
          if (state is HomeInitial) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(child: Text('Please Scan QR')),
                  Positioned(
                   right: 50,
                   left: 50,
                   bottom: 50,
                    child: ElevatedButton(
                      onPressed: () {
                  
                      },
                      child: const Text("Scan QR"),
                    ),
                  )
                ],
              ),
            );
          } else if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is HomeComplate) {
            return Container();
          } else {
            return Center(child: Text((state as HomeError).msg));
          }
        },
      ),
    );
  }
}
