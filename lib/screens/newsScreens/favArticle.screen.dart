import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/article.model.dart';
import 'package:news_app/providers/theme.provider.dart';
import 'package:news_app/screens/newsScreens/test_news.dart';
import 'package:news_app/screens/webviewScreen.dart';
import 'package:news_app/services/database_service.dart';

class FavArticleScreen extends ConsumerWidget {
  const FavArticleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Fav Article"),
        ),
        body: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(ref.read(userIdProvider))
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final articleData = snapshot.data!.get('news') as List;

                  if (snapshot.data == null) {
                    return const Text("No fav exists");
                  } else {
                    return ListView.builder(
                      itemCount: articleData.length,
                      itemBuilder: (context, index) {
                        // Article article = Article(
                        //     title: articleData[index]['title'],
                        //     publishedAt: DateTime.fromMillisecondsSinceEpoch(
                        //         articleData[index]['publishedAt']));
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8, left: 8),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InAppWebView(
                                        url: articleData[index]['url'],
                                        title: articleData[index]['title'])),
                              );
                            },
                            dense: true,
                            titleAlignment: ListTileTitleAlignment.center,
                            minVerticalPadding: 8,
                            visualDensity:
                                VisualDensity.defaultDensityForPlatform(
                                    TargetPlatform.android),
                            subtitle: Text(DateTime.fromMillisecondsSinceEpoch(
                                    articleData[index]['publishedAt'])
                                .toString()
                                .split(' ')
                                .first),
                            // trailing: ActionChip(
                            //   onPressed: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => InAppWebView(
                            //               url: articleData[index]['url'],
                            //               title: article.title!),
                            //         ));
                            //   },
                            //   padding: const EdgeInsets.all(8),
                            //   side: BorderSide.none,
                            //   backgroundColor: colorContext(context).surface,
                            //   shape: const StadiumBorder(),
                            //   label: const Text(
                            //     "Read",
                            //     style: TextStyle(),
                            //   ),
                            // ),
                            tileColor: colorContext(context).secondaryContainer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            title: Text(articleData[index]['title']),
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: articleData[index]['urlToImage'] == null
                                    ? const Icon(Icons.image_rounded)
                                    : Image.network(
                                        articleData[index]['urlToImage'],
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            const Card(
                                                margin: EdgeInsets.all(0),
                                                child:
                                                    Icon(Icons.image_rounded)),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        )

        //  ref.watch(favArticlesProvider).when(
        //       data: (data) {
        //         return ListView.builder(
        //           itemCount: data.length,
        //           itemBuilder: (context, index) {
        //             return Text(data.elementAt(index).title.toString());
        //           },
        //         );
        //       },
        //       error: (error, stackTrace) => Text(error.toString()),
        //       loading: () => const CircularProgressIndicator(),
        //     ),
        );
  }
}
