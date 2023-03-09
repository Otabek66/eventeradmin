import 'package:dio/dio.dart';
import 'package:eventeradmin/constants/color_const.dart';
import 'package:eventeradmin/models/userQr_model.dart';
import 'package:eventeradmin/screens/home/cubit/home_cubit.dart';
import 'package:eventeradmin/widget/snackbar_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class CheckMemberView extends StatefulWidget {
  CheckMemberView({super.key});

  @override
  State<CheckMemberView> createState() => _CheckMemberViewState();
}

class _CheckMemberViewState extends State<CheckMemberView> {
  String barcodeScanRes = "";
  UserQr? userData;
  var box = GetStorage();
  String dropdownValue = '1';
  List info = [
    "F.I.O",
    "Company",
    "Phone number",
    "Email",
    "Time",
    "Country",
    "Region",
  ];
  List a = ["", "", "", "", "", "", "", "", "", "", ""];
  String sendingData = "";
  String printerNumber = "";
  TextEditingController controller =
      TextEditingController(text: "172.20.22.138");
  dynamic finalprintnum = "1";

  @override
  Widget build(BuildContext context) {
    var data = context.watch<HomeCubit>();
    var dataFunction = context.read<HomeCubit>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Container(
          // color: Colors.black,
          height: 90.h,
          width: 350.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             
              Padding(
                padding: EdgeInsets.only(left: 5.r),
                child: Text(
                  "QR reader",
                  style: TextStyle(fontSize: 20.sp),
                ),
              )
            ],
          ),
        ),
        backgroundColor: ColorsConst.kprimaryColor,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 520.h,
                width: 360.w,
                child: ListView.builder(
                  itemCount: info.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(info[index],style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500),),
                      subtitle:
                          Text(a[index] == "" ? "No information" : a[index],style: TextStyle(fontSize: 18.sp),),
                      // subtitle: Text(),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 35.r,
              left: 20.r,
              right: 10.r,
              child: Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsConst.kprimaryColor,
                          fixedSize: Size(150.w, 40.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100))),
                      onPressed: () {
                        sendData(context);
                      },
                      child: Text("Send data")),
                  SizedBox(
                    width: 22.w,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsConst.kprimaryColor,
                          fixedSize: Size(150.w, 40.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100))),
                      onPressed: () {
                        // print(controller.text);
                        // jsonTest();
                        scanQr(context);
                      },
                      child: Text("Scan Qr")),
                ],
              ))
        ],
      ),
    );
  }

  //This scanQr function for scaning qr code and get datas
  void scanQr(BuildContext context) async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
    print(barcodeScanRes);
    if (barcodeScanRes != "") {
      // SnackBarWidget.showSnackBar(context, "Qr read", Colors.green);
      print("Qr read =>>> $barcodeScanRes");
    }
    try {
      var response = await Dio().get('https://api.teda.uz:8082/api/user/getUserByQR?code=$barcodeScanRes', options: Options(headers: {
        "Authorization" : "Bearer 6189750542:AAHumZZIJbwfwrdBtSwzsTffCCxboIAGVRo"
      }));
       userData = UserQr.fromJson(response.data);
       print(response.statusCode);
       if(response.statusCode == 200 ||response.statusCode== 201){
        SnackBarWidget.showSnackBar(context, "User found", Colors.green);
       a[0] = userData!.data!.fullName ?? "";
       a[1] = userData!.data!.company ?? "";
       a[2] = userData!.data!.phone ?? "";
       a[3] = userData!.data!.email ?? "";
       a[4] = userData!.data!.registeredTime == null ? "" :userData!.data!.registeredTime.toString();
       a[5] = userData!.data!.address!.country!.name ?? "";
       a[6] = userData!.data!.address!.region!.name ?? "";
       
      print(userData);
      setState(() {});
       }else if(response.statusCode==400){
       a[0] = "";
       a[1] = "";
       a[2] = "";
       a[3] = "";
       a[4] = "";
       a[5] = "";
       a[6] = "";
        SnackBarWidget.showSnackBar(context, "User not found", Colors.amberAccent);
        setState(() {
          
        });
       }else if(response.statusCode==400 || response.statusCode==500){
        SnackBarWidget.showSnackBar(context, "Internet error", Colors.red);
       }

    } catch (e) {
      
      print("Error $e");
    }


  }

//This jsonTest function for testing database
  void jsonTest() async {
    try {
      var response = await Dio().get('https://api.teda.uz:8082/api/user/getUserByQR?code=fe96426c-044d-49a0-b860-3d75757dac0a', options: Options(headers: {
        "Authorization" : "Bearer 6189750542:AAHumZZIJbwfwrdBtSwzsTffCCxboIAGVRo"
      }));
       userData = UserQr.fromJson(response.data);
       a[0] = userData!.data!.fullName ?? "";
       a[1] = userData!.data!.company ?? "";
       a[2] = userData!.data!.phone ?? "";
       a[3] = userData!.data!.email ?? "";
       a[4] = userData!.data!.registeredTime == null ? "" :userData!.data!.registeredTime.toString();
       a[5] = userData!.data!.address!.country!.name ?? "";
       a[6] = userData!.data!.address!.region!.name ?? "";
      print(userData);
      setState(() {});
    } catch (e) {
      SnackBarWidget.showSnackBar(context, "Internet error", Colors.red);
      print("Error $e");
    }
  }

//This sendData function for send data to local computer
  sendData(BuildContext context) async {
    try {
      if (barcodeScanRes != "") {
 
        var response1 = await Dio().patch('https://api.teda.uz:8082/api/request/2?qrcode=$barcodeScanRes', options: Options(headers: {
        "Authorization" : "Bearer 6189750542:AAHumZZIJbwfwrdBtSwzsTffCCxboIAGVRo"
      }));
        UserQr qrres = UserQr.fromJson(response1.data);
        print(response1.data);
       if(qrres.success==true){
        SnackBarWidget.showSnackBar(context, "Data updated", Colors.green);
       }
          
        
        print(response1.data);
      } else {
        print("no qr");
        SnackBarWidget.showSnackBar(context, "Please Scan Qr", Colors.red);
      }
    } catch (e) {
      SnackBarWidget.showSnackBar(context, "Internet error", Colors.red);
      print("Error $e");
    }
  }
}
