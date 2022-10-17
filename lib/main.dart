import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String>? info;

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
        return ListTile(title: Text(info![index]),);
      }
      ),
      itemCount: info!.length,)
    );
  }
}
