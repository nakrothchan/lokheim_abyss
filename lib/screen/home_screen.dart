import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:lokheim_abyss/config/app.dart';
import 'package:http/http.dart' as http;
import 'package:lokheim_abyss/screen/page_detail_screen.dart';
import 'package:lokheim_abyss/services/auth_service.dart';
import 'package:lokheim_abyss/services/page_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> banners = [];
  List<dynamic> pages = [];
  Future<void> fetchBanner() async {
    try {
      final response = await http.get(Uri.parse('$API_URL/api/banners'));
      final banners = jsonDecode(response.body);
      print(banners);
      setState(() {
        this.banners = banners;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchPages() async {
    try {
      List<dynamics> pages =
          (await PageService.fetchBanner()) as List<dynamics>;
      setState(() {
        this.pages = pages;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    AuthService.checkLogin().then((loggedIn) {
      if (!loggedIn) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
    fetchBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text('Abyss'),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PageDetailSCreen(
                              id: pages[index]['id'],
                            ),
                          ),
                        );
                      },
                      title: Text(pages[index]['title']),
                    );
                  })
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Home'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 250,
                child: Swiper(
                  autoplay: true,
                  itemCount: banners.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        '$API_URL/${banners[index]['imageUrl']}',
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Post",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PageDetailSCreen(
                            id: pages[index]['id'],
                          ),
                        ),
                      );
                    },
                    title: Text(pages[index]['title']),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
