import 'package:assessment_test_tokoin/controllers/feeds_controller.dart';
import 'package:assessment_test_tokoin/widgets/news_item.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({Key? key}) : super(key: key);

  @override
  State createState() => _FeedsPageState();
}

class _FeedsPageState extends StateMVC<FeedsPage> {

  _FeedsPageState() : super(FeedsController()) {
    con = controller as FeedsController;
  }
  late FeedsController con;

  @override
  void initState() {
    con.getHeadlineList();
    con.listScrollController.addListener(() {
      if(con.listScrollController.position.atEdge && 
        con.listScrollController.position.pixels == con.listScrollController.position.maxScrollExtent) {
          con.getMoreHeadlineList();
        }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        controller: con.listScrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("News feed", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // While fetching data, show loading indicator
            con.isLoading ?
              SizedBox(
                height: MediaQuery.of(context).size.height*0.7,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ) :
            // While done fetching data, show list
            con.headlineList.isNotEmpty ?
              Column(
                children: con.headlineList.map((_item) {
                  return NewsItem(newsItem: _item);
                }).toList(),
              ) :
            // If no data available, show error message
              SizedBox(
                height: MediaQuery.of(context).size.height*0.7,
                child: const Center(
                  child: Text("Can't find any news!"),
                ),
              ),
              SizedBox(
                height: 70,
                child: con.isLoadingMore ? const Center(child: CircularProgressIndicator()) : null
              )
          ],
        ),
      ),
    );
  }
}