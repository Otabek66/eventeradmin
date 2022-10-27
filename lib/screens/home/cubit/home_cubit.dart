// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:eventeradmin/screens/home/state/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());

  String? uri;

  List infoType = [
    "F.I.SH",
    "Tashkilot",
    "Status",
    "Davlat",
    "Viloyat",
    "Tadbir haqida qayerdan bildingiz?",
    "Yil",
    "E-mail",
    "Telefon"
  ];
  List infoNull = [
    "Familiya, ism",
    "Tashkilot nomi",
    "resident or nonresident",
    "Qayerdan",
    "Viloyat",
    "Tadbir haqida qayerdan bildingiz?",
    "Yil",
    "E-mail",
    "Telefon raqami"
  ];
  String? scanBarcode;
  List? info;
  Future getWebsiteData() async {
    emit(HomeComplate(info: infoNull));
    try {
      if (uri != null) {
        final url = Uri.parse(uri!);
        final response = await http.get(url);
        dom.Document html = dom.Document.html(response.body);

        final keys = html
            .querySelectorAll("#w0 > tBody > tr > td")
            .map((element) => element.innerHtml.trim())
            .toList();
        print("Count: ${keys.length}");

        for (final key in keys) {
          print(key);
        }
        emit(HomeComplate(info: keys));
      } else {
       HomeComplate(info: infoNull);
      }
    } catch (e) {
      emit(HomeError(msg: e.toString()));
    }
  }
   String barcodeScanRes="";
  Future<void> scanQR() async {
    
   
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      emit(HomeLoading());
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
      uri = barcodeScanRes;

      try {
      if (uri != null) {
        print("Print uri >>>>> $uri");
        final url = Uri.parse(uri!);
        final response = await http.get(url);
        dom.Document html = dom.Document.html(response.body);

        final keys = html
            .querySelectorAll("#w0 > tBody > tr > td")
            .map((element) => element.innerHtml.trim())
            .toList();
        print("Count: ${keys.length}");

        for (final key in keys) {
          print(key);
        }
        info = keys;
        emit(HomeComplate(info: keys));
        // return;
      } else {
       emit(HomeComplate(info: infoNull));
      }
    } catch (e) {
      emit(HomeError(msg: e.toString()));
    }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

void getHttp() async {
  try {
    var response = await Dio().get('192.168.0.135/reg');
    print(response);
  } catch (e) {
    print("Error >>>>>>> $e");
  }
}

}
