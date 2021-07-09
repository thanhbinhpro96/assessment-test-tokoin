import 'package:assessment_test_tokoin/models/news.dart';
import 'package:assessment_test_tokoin/pages/news_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsItem extends StatefulWidget {

  final News newsItem;

  const NewsItem({ Key? key, required this.newsItem }) : super(key: key);

  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (BuildContext context) {
              return NewsDetail(newsItem: widget.newsItem);
            })
          );
        },
        child: Card(
          child: ListTile(
            leading: SizedBox(
              height: 100,
              width: 70,
              child: widget.newsItem.imageUrl.isNotEmpty ? Image.network(
                widget.newsItem.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, object, trace) {
                  return const Icon(Icons.broken_image, size: 26);
                },
              ) : const Icon(Icons.broken_image, size: 26),
            ),
            title: Text(widget.newsItem.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(widget.newsItem.description, maxLines: 2, overflow: TextOverflow.ellipsis),
          )
        ),
      ),
    );
  }
}