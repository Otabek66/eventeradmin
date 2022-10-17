
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List info = [];

  @override
  void initState() {
    super.initState();

    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse(
        "https://www.ictweek.uz/uz/qr-check/023bb682-35e1-11ed-b5a6-005056b672ed");
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final keys = html
        .querySelectorAll("#w0 > tBody > tr > td")
        .map((element) => element.innerHtml.trim())
        .toList();

        print("Count: ${keys.length}");
        for(final key in keys){
          debugPrint(key);
        }
        info = keys;
        print(info[1]);
        setState(() {
          
        });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("App Bar"),
      ),
      body: ListView.builder(itemBuilder: ((context, index) {
        return ListTile(title: Text(index != info.length-1 ? info[index] : ""),);
      }
      ),
      itemCount: info.length,)
    );
  }
}
