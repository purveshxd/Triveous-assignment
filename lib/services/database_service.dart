import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/article.model.dart';

final favArticleListProvider = StateProvider<List<Article>>((ref) {
  List<Article> list = [];
  ref.watch(favArticlesProvider).whenData((value) => list.addAll(value));
  return list;
});

//
final dbProvider =
    Provider((ref) => FirebaseFirestore.instance.collection('users'));

//
final userIdProvider =
    Provider((ref) => FirebaseAuth.instance.currentUser!.uid);

//
final favArticlesProvider = FutureProvider((ref) async {
  final userId = ref.watch(userIdProvider);
  final db = ref.watch(dbProvider);
  final docs = await db.doc(userId).get();

  final List<Article> listArticle = [];
  final docList = docs.get('news') as List;
  for (var element in docList) {
    listArticle.add(Article.fromJson(element));
  }

  return listArticle;
});

//
final setFavArticleProvider =
    FutureProvider.family<void, Article>((ref, favArticle) async {
  //
  final userId = ref.watch(userIdProvider);
  final db = ref.watch(dbProvider);
  final articleList = ref.watch(favArticlesProvider).value;
  final tempList = [];

  for (var article in articleList!) {
    tempList.add(article.toJson());
  }
  final newList = [...tempList, favArticle.toJson()];
  try {
    return await db.doc(userId).set({"news": newList});
  } on FirebaseException catch (e) {
    debugPrint(e.message);
  }
});
