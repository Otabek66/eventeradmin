// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:eventeradmin/screens/home/state/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeSplash());

  String? uri;

  Future getWebsiteData() async {
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
      }else{
        emit(HomeInitial());
      }
    } catch (e) {
      emit(HomeError(msg: e.toString()));
    }
  }
}
