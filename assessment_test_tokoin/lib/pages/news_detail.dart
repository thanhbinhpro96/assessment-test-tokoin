import 'package:assessment_test_tokoin/models/news.dart';
import 'package:assessment_test_tokoin/settings/helper.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {

  final News newsItem;

  const NewsDetail({ Key? key, required this.newsItem }) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: MediaQuery.of(context).size.height*0.4,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(widget.newsItem.imageUrl, fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // News title
                  Text(widget.newsItem.title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  // News description
                  Text(widget.newsItem.description, style: const TextStyle(fontSize: 16, color: Colors.black54)),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // News author
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 10),
                          Text(
                            widget.newsItem.author,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      // News publish date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.timer),
                          const SizedBox(width: 10),
                          Text(formatDateTime(widget.newsItem.publishedAt))
                        ],
                      ),
                    ],
                  ),
                  // News content
                  const SizedBox(height: 20),
                  Text(widget.newsItem.content),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}