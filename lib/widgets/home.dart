import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CardWidget extends StatefulWidget {
  final Map post;
  final int index;
  final Box postBox;

  const CardWidget({
    Key? key,
    required this.post,
    required this.index,
    required this.postBox,
  }) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.post['imagePath'] != ''
              ? Image.file(
                  File(widget.post['imagePath']),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.post['caption'] ?? '',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: widget.post['liked'] == true
                      ? Colors.red
                      : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    widget.post['liked'] = !(widget.post['liked'] ?? false);
                    widget.postBox.putAt(widget.index, widget.post);
                  });
                },
              ),
              Text('${widget.post['liked'] == true ? 1 : 0} Likes'),
            ],
          ),
        ],
      ),
    );
  }
}
















// Card(
//                 margin: EdgeInsets.all(10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     post['imagePath'] != ''
//                         ? Image.file(
//                             File(post['imagePath']),
//                             width: double.infinity,
//                             height: 200,
//                             fit: BoxFit.cover,
//                           )
//                         : SizedBox.shrink(),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         post['caption'] ?? '',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           icon: Icon(
//                             Icons.favorite,
//                             color: post['liked'] == true
//                                 ? Colors.red
//                                 : Colors.grey,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               post['liked'] = !(post['liked'] ?? false);
//                               postBox.putAt(index, post);
//                             });
//                           },
//                         ),
//                         Text('${post['liked'] == true ? 1 : 0} Likes'),
//                       ],
//                     ),
//                   ],
//                 ),
//               );