import 'package:assessment_test_tokoin/models/news.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // News author
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.4,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Icon(Icons.person)
                              ),
                              const WidgetSpan(
                                child: SizedBox(width: 10)
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(widget.newsItem.author, style: const TextStyle(color: Colors.black))
                                )
                              ),
                            ]
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // News publish date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.timer),
                          const SizedBox(width: 10),
                          Text(DateFormat("dd/MM/yyyy - HH:mm").format(widget.newsItem.publishedAt))
                        ],
                      ),
                    ],
                  ),
                  // News content
                  const SizedBox(height: 20),
                  Text(widget.newsItem.content),
                  // News source
                  const SizedBox(height: 20),
                  const Text("Source:"),
                  GestureDetector(
                    onTap: () async {
                      if(await canLaunch(widget.newsItem.url)) {
                        await launch(widget.newsItem.url);
                      } else {
                        Fluttertoast.showToast(msg: 'Could not launch $widget.newsItem.url');
                      }
                    },
                    child: Text(widget.newsItem.url, style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}