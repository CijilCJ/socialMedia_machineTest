import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/view/addPage.dart';
import 'package:task/widgets/home.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box postBox = Hive.box('postBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Social App'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: postBox.listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return Center(child: Text('No posts yet!'));
          }

          List posts = box.values.toList();

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              var post = posts[index];
              return CardWidget(post: post, index: index, postBox: postBox);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddPostPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
