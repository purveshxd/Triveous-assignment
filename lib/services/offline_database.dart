
import 'package:hive/hive.dart';
import 'package:news_app/models/article.model.dart';

class OfflineData {
  final box = Hive.box("newsBox");

  saveArticle(List<Article> article) {
    List tempList = [];
    for (var element in article) {
      tempList.add(element.toJson());
    }
    box.put('article', tempList);
    // debugPrint("statement");
    // debugPrint(box.get('article'));
  }

  List<Article> getArticle() {
    final List<Article> articleTempList = [];

    final articles = box.get('article', defaultValue: []) as List;
    // final articleTempList = articles.map((e) => Article.fromJson(e)).toList();

    for (var element in articles) {
      articleTempList.add(Article.fromJson(element));
    }
    // print(articleFromJson(articleTempList));
    // for (var element in articleTempList) {
    //   articleList.add(element);
    // }
    // debugPrint(articleList.toString());
    return articleTempList;
  }
}
