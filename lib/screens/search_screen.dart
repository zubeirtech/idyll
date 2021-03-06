import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idyll/providers/query.dart';
import 'package:idyll/widgets/screen_header.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/query_list.dart';
import './query_screen.dart';
import 'dart:io';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchQueryController = TextEditingController();
  String searchQuery = "Search query";
  List<String> queries = [];
  bool _isLoading = false;

  List<String> blacklist = [
    "corona",
    "coronavirus",
    "covid",
    "sarscov-2",
    "sars-cov-2",
    "sarscov",
    "sars-cov",
    "pandemic",
    "covid-19"
  ];

  @override
  void didChangeDependencies() {
    Provider.of<Query>(context).getQueries();

    super.didChangeDependencies();
  }

  Widget _buildSearchField() {
    return TextField(
      cursorColor: Colors.black,
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search news...",
        focusColor: Colors.black,
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black),
      ),
      style: GoogleFonts.openSans(
          textStyle: TextStyle(color: Colors.black, fontSize: 16.0)),
      onChanged: (query) => updateSearchQuery(query),
      onSubmitted: _handleSubmitted,
    );
  }

  void _handleSubmitted(String val) {
    if (Platform.isIOS && blacklist.contains(val.trim().toLowerCase())) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'We apologize',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(
            "We are not able to show you search results about '$val' as we are not part of a recognized institution",
            style: GoogleFonts.openSans(),
          ),
        ),
      );
      return;
    }

    Provider.of<Query>(context, listen: false).addQuery(val.trim()).then((_) {
      Navigator.of(context)
          .popAndPushNamed(QueryScreen.routeName, arguments: val.trim());
      _clearSearchQuery();
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Colors.white,
        title: _buildSearchField(),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ScreenHeader("Recent searches"),
                    ),
                    SizedBox(height: 20),
                    QueryList()
                  ],
                ),
              ),
            ),
    );
  }
}
