import 'package:flutter/material.dart';
import 'package:news_app/models/article.model.dart';
import 'package:news_app/providers/theme.provider.dart';
import 'package:news_app/screens/newsScreens/test_news.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewsDetailScreen(
                    article: article,
                  )),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.hardEdge,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  errorBuilder: (context, error, stackTrace) => const Card(
                      margin: EdgeInsets.all(0),
                      child: Icon(Icons.image_rounded)),
                  fit: BoxFit.cover,
                  article.urlToImage.toString(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15)
                  .copyWith(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "article.author",
                          style: TextStyle(
                              color: colorContext(context).surfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  // IconButton(
                  //   padding: const EdgeInsets.all(0),
                  //   onPressed: () {},
                  //   icon: Visibility(
                  //     visible: false,
                  //     replacement: Image.asset(
                  //       Constants.heart_filled,
                  //       scale: MediaQuery.of(context).size.width / 22,
                  //     ),
                  //     child: Image.asset(
                  //       Constants.heart_outline_white,
                  //       scale: MediaQuery.of(context).size.width / 22,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
