import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/screens/newsScreens/favArticle.screen.dart';
import 'package:news_app/screens/newsScreens/test_news.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/services/offline_database.dart';
import 'package:news_app/widgets/news_card.widget.dart';
import 'package:news_app/widgets/news_tile.widget.dart';

final pageViewChangerProvider = StateProvider<List<bool>>((ref) {
  return [true, false];
});
final isGridView = StateProvider<bool>((ref) {
  return true;
});

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  @override
  void initState() {
    NewsService().saveOfflineData();
    super.initState();
    checkConnectivity().then((result) {
      setState(() {
        _connectionStatus = result;
      });
    });
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _connectionStatus = result;
      });
    });
  }

  Future<ConnectivityResult> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _connectionStatus == ConnectivityResult.none
            ? ListView.builder(
                itemCount: OfflineData().getArticle().length,
                itemBuilder: (context, index) => NewsTile(
                  article: OfflineData().getArticle()[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(
                                article: OfflineData().getArticle()[index],
                              )),
                    );
                  },
                ),
              )
            : FutureBuilder(
                future: NewsService().getHeadlines(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FavArticleScreen(),
                                    ));
                              },
                              icon: Image.asset(
                                Constants.heartFilled,
                                scale: MediaQuery.of(context).size.width / 20,
                              ),
                            )
                          ],
                          floating: true,
                          pinned: true,
                          title: const Text("News App"),
                          centerTitle: true,
                          flexibleSpace: const FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        ref
                                            .watch(isGridView.notifier)
                                            .update((state) => !state);
                                      },
                                      icon: ref.watch(isGridView)
                                          ? const Icon(
                                              Icons.table_rows_rounded,
                                            )
                                          : const Icon(
                                              Icons.grid_view_rounded,
                                            )),
                                ],
                              )),
                        ),
                        SliverVisibility(
                          replacementSliver: SliverGrid.builder(
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) => NewsCard(
                              article: snapshot.data!.elementAt(index),
                            ),
                          ),
                          visible: ref.watch(isGridView),
                          sliver: SliverList.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) => NewsTile(
                                    article: snapshot.data!.elementAt(index),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewsDetailScreen(
                                                  article: snapshot.data!
                                                      .elementAt(index),
                                                )),
                                      );
                                    },
                                  )),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
      ),
    );
  }
}
