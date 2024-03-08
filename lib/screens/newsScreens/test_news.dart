import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/article.model.dart';
import 'package:news_app/providers/theme.provider.dart';
import 'package:news_app/screens/webviewScreen.dart';
import 'package:news_app/services/database_service.dart';


final favArticleProvider = StateProvider<bool>((ref) {
  return false;
});

class NewsDetailScreen extends ConsumerWidget {
  final Article article;
  const NewsDetailScreen({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with fading image
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: article.urlToImage == null
                  ? const Icon(Icons.image_rounded)
                  : _buildFadingImage(),
            ),
            pinned: true,
          ),
          // News content
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                  child: Column(
                    children: [
                      Text(
                        article.title,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          article.source == null
                              ? Container()
                              : buildPill(
                                  context, article.source.name.toString()),
                          const SizedBox(
                            width: 5,
                          ),
                          buildPill(context,
                              article.publishedAt.toString().split(' ').first),
                          const Spacer(),
                          IconButton(
                            padding: const EdgeInsets.all(15),
                            onPressed: () {
                              ref.watch(
                                setFavArticleProvider.call(article),
                              );
                            },
                            icon: Image.asset(
                              ref.watch(favArticleProvider)
                                  ? Constants.heartOutlineWhite
                                  : Constants.heartFilled,
                              scale: MediaQuery.of(context).size.width / 25,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                _buildDescription(),
                _buildNewsContent(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: FilledButton.tonal(
                      style: FilledButton.styleFrom(),
                      onPressed: () async {
                        debugPrint(article.url);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InAppWebView(
                                title: article.title,
                                url: article.url,
                              ),
                            ));
                        // await launchUrl(Uri.parse(article.url!));
                      },
                      child: const Text("Read full article")),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFadingImage() {
    debugPrint(article.urlToImage.toString());
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          article.urlToImage.replaceFirst('https', 'http'),
          errorBuilder: (context, error, stackTrace) => Icon(Icons.image_rounded),
          fit: BoxFit.cover,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.0, 0.6),
              end: const Alignment(0.0, 0.0),
              colors: <Color>[
                Colors.transparent,
                Colors.black.withOpacity(0.2),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPill(context, String content) {
    return Chip(
      padding: const EdgeInsets.all(4),
      side: BorderSide.none,
      backgroundColor: colorContext(context).secondaryContainer,
      shape: const StadiumBorder(),
      label: Text(
        content,
        style: const TextStyle(),
      ),
    );
  }

  Widget _buildDescription() {
    if (article.description == null) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          article.description.toString(),
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      );
    }
  }

  Widget _buildNewsContent() {
    if (article.content == null) {
      return Container();
    } else {
      return Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
        child: Text(
          article.content.toString().split('[').first,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      );
    }
  }
}
