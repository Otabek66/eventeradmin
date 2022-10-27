import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eventeradmin/models/info_model.dart';



class InfoService{

  static Future<List<TedaJson>?> getInfo()async{
    try {
    Response response = await Dio().get('http://reg.teda.uz/?qrcode=IBK467792');
    // List<TedaJson> data = (response.data).map((e) => TedaJson.fromJson(e)).toList();
    List<TedaJson> result = [];
    result[0] = TedaJson.fromJson(response.data);
    print("Result >>>> ${TedaJson.fromJson(response.data)}");
    print(result[0]);
     return result;

    
    } catch (e) {
      print("Error >>>>$e");
    }
  }
}