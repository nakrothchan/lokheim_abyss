import 'package:flutter/material.dart';
import 'package:lokheim_abyss/services/page_service.dart';

class PageDetailSCreen extends StatefulWidget {
  final String id;
  const PageDetailSCreen({super.key, required this.id});

  @override
  State<PageDetailSCreen> createState() => _PageDetailSCreenState();
}

class _PageDetailSCreenState extends State<PageDetailSCreen> {
  dynamic _page = {};

  @override
  void initState() {
    super.initState();
    PageService.fetchPage(widget.id).then((page) {
      setState(() {
        _page = page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_page['title']),
      ),
      body: Container(
        child: Text(_page['content']),
      ),
    );
  }
}
