import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final List<dynamic> userList;
  final int pageIndex;

  const UserPage({Key? key, required this.userList, required this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int start = (pageIndex - 1) * 6;
    final int end = pageIndex * 6;
    final List<dynamic> pageData = userList.sublist(start, end < userList.length ? end : userList.length);

    return Container(
      child: ListView.builder(
        itemCount: pageData.length,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(pageData[index]['avatar']),
                    backgroundColor: Colors.indigo,
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('ID: ${pageData[index]['id']}'),
                    Text('First name: ${pageData[index]['first_name']}'),
                      Text('Last name: ${pageData[index]['last_name']}'),
                  ],)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}