import 'package:bt_flutter/user_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<dynamic> userList = [];
  int currentPage = 1;
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users?page=$currentPage'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        userList.addAll(data['data']);
        totalPages = data['total_pages'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page + 1;
                });
                if (currentPage == totalPages && userList.length < totalPages * 6) {
                  fetchData();
                }
              },
              itemCount: totalPages,
              itemBuilder: (context, index) {
                return UserPage(userList: userList, pageIndex: index + 1);
              },
            ),
          ),
        ],
      ),
    );
  }
}