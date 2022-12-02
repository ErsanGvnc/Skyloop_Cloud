// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, file_names, prefer_if_null_operators, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maltepe/Screens/detailScreen.dart';
import 'package:maltepe/Screens/webScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Variables/variables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  habercek() async {
    var gelen = await http.get(
      Uri.parse(newsApi),
    );
    haberler = jsonDecode(gelen.body);

    sonHaberler = haberler["articles"];

    setState(() {});
  }

  @override
  void initState() {
    habercek();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    Future<void> _refresh() async {
      habercek();
    }

    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // DrawerHeader(
                    //   child: Image.asset(
                    //     "assets/images/skyloop.png",
                    //     fit: BoxFit.cover,
                    //     filterQuality: FilterQuality.high,
                    //   ),
                    // ),
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/skyloop.png",
                          ),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                      child: SizedBox(),
                    ),
                    ListTile(
                      leading: Image.asset(
                        "assets/images/appLogo.png",
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        width: 50,
                      ),
                      title: Text("Skyloop Cloud"),
                      onTap: () async {
                        await launchUrl(
                          Uri.parse(myLinkedin),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Image.network(
          "https://www.skyloop.cloud/assets/img/skyloop-logo.png",
          fit: BoxFit.cover,
          height: 50,
          filterQuality: FilterQuality.high,
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Site(
                    verilink: "https://github.com/ErsanGvnc",
                  ),
                ),
              );
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://avatars.githubusercontent.com/u/57798484?v=4",
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.separated(
          controller: mainController,
          itemCount: sonHaberler.length,
          itemBuilder: (context, index) {
            return sonHaberler[index]["urlToImage"] != null
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            veri1: sonHaberler[index]["urlToImage"] ?? "",
                            veri2: sonHaberler[index]["source"]["name"] ?? "",
                            veri3: sonHaberler[index]["publishedAt"] ?? "",
                            veri4: sonHaberler[index]["title"] ?? "",
                            veri5: sonHaberler[index]["description"] ?? "",
                            veri6: sonHaberler[index]["author"] ?? "",
                            veri7: sonHaberler[index]["url"] ?? "",
                            veri8: sonHaberler[index]["content"] ?? "",
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(sonHaberler[index]["urlToImage"]),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                sonHaberler[index]["source"]["name"] ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                sonHaberler[index]["publishedAt"] ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            sonHaberler[index]["title"] ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            sonHaberler[index]["description"] ?? "",
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                sonHaberler[index]["author"] ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox();
          },
          separatorBuilder: (context, index) {
            return sonHaberler[index]["urlToImage"] != null
                ? const Divider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                  )
                : SizedBox();
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            mainController.animateTo(
              0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOut,
            );
          },
          child: const Icon(
            Icons.expand_less,
            size: 50,
          ),
        ),
      ),
    );
  }
}
