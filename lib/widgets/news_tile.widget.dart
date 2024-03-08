// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:news_app/models/article.model.dart';

class NewsTile extends StatelessWidget {
  final void Function()? onTap;
  final Article article;
  const NewsTile({
    Key? key,
    this.onTap,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0, right: 4, left: 4),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        errorBuilder: (context, error, stackTrace) =>
                            const Card(
                                margin: EdgeInsets.all(0),
                                child: Icon(Icons.image_rounded)),
                        fit: BoxFit.cover,
                        article.urlToImage.toString(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(article.source.name.toString(),
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        article.title,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        article.publishedAt.toString().split(' ').first,
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
