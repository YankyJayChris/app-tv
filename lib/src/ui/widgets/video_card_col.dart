import 'package:flutter/material.dart';
import '../../../src/models/video.dart';

class VideoWidgetHor extends StatelessWidget {
  final Video video;

  VideoWidgetHor({this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * (50 / 100),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/videodetail', arguments: video);
          },
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * (60 / 100),
                height: MediaQuery.of(context).size.height * (15 / 100),
                // padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.purple[800],
                  image: DecorationImage(
                    image: NetworkImage(video.thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(.9),
                        Colors.black.withOpacity(.2),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Text(video.duration,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                            maxLines: 3),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(video.title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.start,
                        maxLines: 3),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Text(video.owner.username,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.purple[800]),
                        textAlign: TextAlign.start,
                        maxLines: 3),
                  ),
                  Container(
                    child: Text("${video.views} views",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                        textAlign: TextAlign.start,
                        maxLines: 3),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
