import 'dart:convert';
import 'package:first/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Future<Post> getApi() async {
    var responsre = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (responsre.statusCode == 200) {
      return Post.fromJson(jsonDecode(responsre.body));
    } else {
      throw Exception('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('F I R S T'),
      ),
      
      body: FutureBuilder(
        future: getApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Text('  UserId:   ${snapshot.data?.userId}');
              },
            );
          } else {
            Text('${snapshot.hasError}');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
