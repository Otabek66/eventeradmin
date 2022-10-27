import 'package:dio/dio.dart';
import 'package:eventeradmin/constants/color_const.dart';
import 'package:eventeradmin/models/info_model.dart';
import 'package:eventeradmin/screens/home/cubit/home_cubit.dart';
import 'package:eventeradmin/service/info_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QrView extends StatelessWidget {
  QrView({super.key});
  String barcodeScanRes = "";
  @override
  Widget build(BuildContext context) {
    var data = context.watch<HomeCubit>();
    var dataFunction = context.read<HomeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qr View"),
        backgroundColor: ColorsConst.kprimaryColor,
      ),
      body: Stack(
        children: [
          FutureBuilder(
                  future: InfoService.getInfo(),
                  builder: (context, AsyncSnapshot snap){
                    if (!snap.hasData) {
                      return Center(child: CircularProgressIndicator.adaptive(),);
                    } else if(snap.hasError){
                      return Center(child: Text("No Internet Connection"),);
                    } else{
                      var data1 = snap.data;
          return Column(
            children: [
              SizedBox(
                height: 575.h,
                width: 360.w,
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(snap.data![0].tel),
                      // subtitle: Text(data.info[index] ?? data.infoNull[index]),
                    );
                  },
                ),
              ),
            ],
          );}}),

          Positioned(
              bottom: 40,
              left: 60,
              right: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsConst.kprimaryColor,
                      fixedSize: Size(250.w, 40.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100))),
                  onPressed: () {
                  //  json();
                  InfoService.getInfo();
                  },
                  child: Text("Scan QR")))
        ],
          ));}
    
  

  void scanQr() async {
    barcodeScanRes= await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
    try {
      var response = await Dio().get('http://reg/?qrcode=IBK467792');
      List<TedaJson> data = (response.data).map((e) => TedaJson.fromJson(e)).toList(); 
      print(data.length);
    } catch (e) {
      print("Error >>>>>>> $e");
    }
  }
  void json() async{
try {
      var response = await Dio().get('http://reg.teda.uz/?qrcode=IBK467792');
      
      print(response);
    } catch (e) {
      print("Error >>>>>>> $e");
    }
  }

}