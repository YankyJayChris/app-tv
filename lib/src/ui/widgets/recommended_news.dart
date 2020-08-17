import 'package:flutter/material.dart';
import 'package:newsapp/src/models/article.dart';

class RecommendedNews extends StatelessWidget {
  final Article post;

  RecommendedNews({this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/articledetail', arguments: post);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * (50 / 100),
              height: MediaQuery.of(context).size.height * (15 / 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    post.image
                    ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * (50 / 100),
              child: Text(
                post.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 3),
            ),
            
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.visibility,
                      color: Colors.black45,
                    ),
                    Text(
                      " ${post.views} views",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: SizedBox(
                //     height: 5.0,
                //     width: 5.0,
                //     child: Container(
                //       width: 2,
                //       height: 2,
                //       decoration: BoxDecoration(
                //         color: Color(0xff66757F),
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(5.0),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Text(
                  post.textTime,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
