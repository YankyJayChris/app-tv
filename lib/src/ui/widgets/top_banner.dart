import 'package:flutter/material.dart';
import 'package:newsapp/src/models/video.dart';

class TopBanner extends StatelessWidget {

  final Video video;

  TopBanner({this.video});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/videodetail', arguments: video);
          },
          child: Container(
        height: MediaQuery.of(context).size.height * (30 / 100),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
            image: NetworkImage(
                video.thumbnail),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.2),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      image: DecorationImage(
                        image: NetworkImage(
                            video.owner.avatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    video.owner.username,
                    style: TextStyle(color: Colors.white,fontSize: 16,),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                // height: 65.0,
                child: Text(
                    video.title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.start,
                    maxLines: 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
