import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article.model.dart';
import 'package:news_app/services/offline_database.dart';

class NewsService {
  final apiKey = '9e16b606117e49d08feea0f0d9b47b78';

  Future<List<Article>> getHeadlines() async {
    final apiUrl = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=9e16b606117e49d08feea0f0d9b47b78");
    final List<Article> listArticle = [];
    try {
      return await http.get(apiUrl).then((resp) {
        if (resp.statusCode == 200) {
          final data = json.decode(resp.body);
          final articles = data['articles'];
          print(articles);
          for (var article in articles) {
            final articleTemp = Article.fromJson(article);
            // final arc =
            //     articleTemp.copyWith(source: Source(id: 'id', name: 'name'));
            listArticle.add(articleTemp);
          }
        } else {
          debugPrint(resp.body);
          throw Exception(resp.reasonPhrase);
        }
        return listArticle;
      });
    } catch (e) {
      // debugPrint(e.toString());
      rethrow;
    }
  }

  saveOfflineData() {
    getHeadlines().then((articles) {
      final List<Article> articleList = [];
      for (var i = 0; i < 5; i++) {
        debugPrint("STARTED");
        articleList.add(articles[i]);
        debugPrint("SAVED-$i");
      }
      OfflineData().saveArticle(articleList);
    });
  }
}
