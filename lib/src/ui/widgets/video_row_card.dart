import 'package:flutter/material.dart';
import '../../../src/models/video.dart';

class VideoWidgetRow extends StatelessWidget {
  final Video video;
  final bool pop;

  VideoWidgetRow({this.video, this.pop = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: MediaQuery.of(context).size.height * (40 / 100),
        padding: EdgeInsets.only(bottom: 10.0),
        child: InkWell(
          onTap: () {
            if (pop) {
              Navigator.pop(context);
            }
            Navigator.pushNamed(context, '/videodetail', arguments: video);
          },
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * (95 / 100),
                height: MediaQuery.of(context).size.height * (25 / 100),
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
                width: 5.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width * (95 / 100),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                          image: NetworkImage(video.owner.avatar),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * (75 / 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text(video.owner.username,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.purple[800]),
                                    textAlign: TextAlign.start,
                                    maxLines: 3),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 5.0,
                                  width: 5.0,
                                  child: Container(
                                    width: 2,
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: Colors.purple[800],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
