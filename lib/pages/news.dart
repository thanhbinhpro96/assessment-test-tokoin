import 'package:assessment_test_tokoin/controllers/news_controller.dart';
import 'package:assessment_test_tokoin/settings/const.dart';
import 'package:assessment_test_tokoin/widgets/news_item.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State createState() => _NewsPageState();
}

class _NewsPageState extends StateMVC<NewsPage> {

  _NewsPageState() : super(NewsController()) {
    con = controller as NewsController;
  }
  late NewsController con;

  @override
  void initState() {
    con.switchTab(newsCategories.first);
    con.getNewsList();
    con.listScrollController.addListener(() {
      if(con.listScrollController.position.atEdge && 
        con.listScrollController.position.pixels == con.listScrollController.position.maxScrollExtent) {
          con.getMoreNewsList();
        }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return DefaultTabController(
      length: newsCategories.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          // Category list
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: theme.primaryColor,
            onTap: (index) {
              con.switchTab(newsCategories[index]);
              con.rebuild();
              con.getNewsList();
            },
            tabs: newsCategories.map((_category) {
              return Tab(
                text: _category.keyword
              );
            }).toList()
          ),
        ),
        // News list
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: newsCategories.map((_category) {
              if(_category != con.currentCategory) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                controller: con.listScrollController,
                child: Column(
                  children: [
                    // While fetching data, show loading indicator
                    con.isLoading ?
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.7,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ) :
                    // While done fetching data, show list
                    con.newsList.isNotEmpty ?
                      Column(
                        children: con.newsList.map((_item) {
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
              );
            }).toList()
        ),
      ),
    );
  }
}