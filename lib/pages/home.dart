import 'package:assessment_test_tokoin/controllers/home_controller.dart';
import 'package:assessment_test_tokoin/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> {

  _HomePageState() : super(HomeController()) {
    con = controller as HomeController;
  }
  late HomeController con;

  @override
  Widget build(BuildContext context) {
    UserProvider _provider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          _provider.checkUser() ? Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                const Icon(Icons.person_pin, color: Colors.grey),
                const SizedBox(width: 5),
                Text(_provider.getUser.username, style: const TextStyle(color: Colors.black))
              ],
            ),
          ) : Container()
        ],
      ),
      body: con.pages[con.currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: con.currentTab,
        onTap: (_index) {
          con.switchTab(_index);
        },
        selectedLabelStyle: const TextStyle(
          fontSize: 11
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Headlines"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dynamic_feed_outlined),
            label: "News"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"
          ),
        ],
      ),
    );
  }
}