import 'package:flutter/material.dart';
import 'package:newsapp/src/models/article.dart';
// import 'package:newsapp/wigets/image_disp.dart';

String img2 =
    "http://www.dubaiweek.ae/wp-content/uploads/2017/10/Krusty-The-Cone-1-e1507813664264.jpg";

class RowItem extends StatelessWidget {
  final Article post;

  const RowItem({this.post});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/articledetail', arguments: "${post.id}");
          },
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Row(
              children: <Widget>[
                Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width * (35 / 100),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(post.image),
                    ),
                  ),
                  // child: ImageLoder(imageUrl:post.imageUrl),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        post.userData.username,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * (50 / 100),
                          height: 80,
                          child: Text(post.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 3),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
