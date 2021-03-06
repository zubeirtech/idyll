import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'news.dart';

class ProductHunt with ChangeNotifier {
  static const BASE_URL =
      "https://api.producthunt.com/v1/posts?per_page=20&access_token=257765dc273d621ff7dda6b94942655f8f853c2b5cabd05a79b8380e8b696245";

  ProductHunt() {
    getNewsArticles();
  }

  List<String> blacklist = [
    "corona",
    "coronavirus",
    "covid",
    "sarscov-2",
    "sars-cov-2",
    "sarscov",
    "sars-cov",
    "pandemic",
    "covid-19",
    "lockdown",
    "virus",
    "vaccine"
  ];

  List<Article> _newsArticles = [];

  List<Article> get newsArticles {
    return [..._newsArticles];
  }

  Future<void> getNewsArticles() async {
    try {
      final res = await http.get(BASE_URL);
      final extractData = json.decode(res.body) as Map<String, dynamic>;
      _newsArticles = _mapArticle(extractData['posts']);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  List<Article> _mapArticle(List data) {
    final List<Article> loadedArticles = [];
    data.forEach((article) {
      if (Platform.isIOS) {
        String title = article['name'];
        bool res = false;

        for (var item in blacklist) {
          if (title.toLowerCase().contains(item)) {
            res = true;
          }
        }

        if (res) {
          return;
        }
      }

      loadedArticles.add(
        Article(
            provider: "Upvotes: " + article['votes_count'].toString(),
            description: article['tagline'],
            publishedAt: DateTime.parse(article['created_at']),
            title: article['name'],
            url: article['discussion_url'],
            urlToImage: article['thumbnail']['image_url'],
            category: "Product Hunt"),
      );
    });
    return loadedArticles;
  }
}
