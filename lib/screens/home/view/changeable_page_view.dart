import 'package:dio/dio.dart';
import 'package:eventeradmin/constants/color_const.dart';
import 'package:eventeradmin/models/info_model.dart';
import 'package:eventeradmin/screens/home/cubit/home_cubit.dart';
import 'package:eventeradmin/service/info_service.dart';
import 'package:eventeradmin/widget/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_country_state/flutter_country_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import '../../../widget/country_bottom_sheet.dart';

class ChangeablePage extends StatefulWidget {
  ChangeablePage({super.key});

  @override
  State<ChangeablePage> createState() => _ChangeablePageState();
}

class _ChangeablePageState extends State<ChangeablePage> {
  String barcodeScanRes = "";
  List<String> liste = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20'
  ];
  var box = GetStorage();
  String dropdownValue = '1';
  List info = [
    "Qr Code",
    "F.I.O",
    "Company",
    "Position",
    "Phone number",
    "Email",
    "Time",
    "Country",
    "Region",
    "Position Id",
    "Message Id",
  ];
  List a = ["", "", "", "", "", "", "", "", "", "", ""];
  String sendingData = "";
  String printerNumber = "";
  TextEditingController controller =
      TextEditingController(text: "172.20.22.138");
  dynamic finalprintnum = "1";


String selectedCountry = "";
String selectedState = "";
  @override
  Widget build(BuildContext context) {
    var data = context.watch<HomeCubit>();
    var dataFunction = context.read<HomeCubit>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        title: Container(
          // color: Colors.black,
          height: 90.h,
          width: 350.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15.r),
                child: Container(
                  width: 80.w,
                  height: 47.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                    menuMaxHeight: 400.h,
                    itemHeight: 50.h,
                    isExpanded: true,
                    icon: Image.asset(
                      "assets/icons/printer.png",
                      height: 30,
                    ),
                    value: box.read("printernum"),
                    elevation: 10,
                    style:
                        const TextStyle(color: Colors.deepPurple, fontSize: 18),
                    onChanged: (String? value) {
                      //  This is called when the user selects an item.
                      dropdownValue = value!;
                      box.write("printernum", dropdownValue);
                      finalprintnum = box.read("printernum");
                      setState(() {});
                    },
                    items: liste.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.r),
                child: Text(
                  "Regestration with Qr",
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

          Positioned(
            left: 50.w,
            child: ElevatedButton(child: Text("country"),onPressed: (() {
            CountryBottomSheet().showCountry(context: context,
                tap: (){
                 setState(() {
                   selectedCountry = Variables.country;
                      });
                 Navigator.pop(context);
                }
              );
          }),)),
          Positioned(
            top: 100.h,
            child: 
          Text(selectedCountry)
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
                        print(controller.text);
                        jsonTest();
                      },
                      child: Text("Scan QR")),
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
    if (barcodeScanRes != "") {
      SnackBarWidget.showSnackBar(context, "Qr read .", Colors.green);
      print("Qr read =>>> $barcodeScanRes");
    }

    if (barcodeScanRes.length == 9) {
      var response =
          await Dio().get('http://reg.teda.uz/?qrcode=$barcodeScanRes');
      // var result = TedaJson.fromJson(response.data);
      print(barcodeScanRes);
      print("Response =>>>> $response.data");
      if (response.data.length > 3) {
        a = response.data.split("||");
      }
      if (a[0] != "") {
        print(a);
        setState(() {});
      }
      if (a[0] == "") {
        var response3 = await Dio().get(
            'http://${controller.text != "" ? controller.text : "172.20.22.138"}/?qrkod=$barcodeScanRes');
        a = response3.data.split("||");
        print(a);
        setState(() {});
      }
    } else if (barcodeScanRes.length > 9) {
      List b = barcodeScanRes.split("/");
      String barcodeScanRes1 = b[b.length - 1];
      print("Barcode 1 =>>>> $barcodeScanRes1");
      var response4 = await Dio().get(
          'http://${controller.text != "" ? controller.text : "172.20.22.138"}/?qrkod=$barcodeScanRes1');
      a = response4.data.split("||");
      print(a);
      setState(() {});
    } else {
      print("Qr error");
    }
  }

//This jsonTest function for testing database
  void jsonTest() async {
    try {
      var response = await Dio().get('http://reg.teda.uz/?qrcode=ict948572');
      sendingData = response.data;
      a = response.data.split("||");
      print(a);
      setState(() {});
    } catch (e) {
      print("Error $e");
    }
  }

//This sendData function for send data to local computer
  sendData(BuildContext context) async {
    try {
      if (a[0] != "") {
        print(finalprintnum);
        var response1 = await Dio().get(
            'http://${controller.text != "" ? controller.text : "172.20.22.138"}/reg?printer=$finalprintnum&qrkod=${a[0]}&fio=${a[1]}&tashkilot=${a[2]}&lavozim=${a[3]}&tel=${a[4]}&email=${a[5]}&new_date=${a[6]}&davlat_id=${a[7]}&obl_id=${a[8]}&lavozim_id=${a[9]}&message_id=${a[10]}');

        print(response1.data);
        if (response1.data == response1.data) {
          SnackBarWidget.showSnackBar(context, "Data sended", Colors.green);
        }
        print(response1.data);
      } else {
        print("no qr");
        SnackBarWidget.showSnackBar(context, "Please Scan Qr", Colors.red);
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
