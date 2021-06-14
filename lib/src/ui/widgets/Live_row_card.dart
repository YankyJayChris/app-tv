import 'package:flutter/material.dart';
import '../../../src/models/live.dart';

class LiveWidgetRow extends StatelessWidget {
  final Live live;
  final Function onTap;

  LiveWidgetRow({this.live, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey[200], width: 1.0),
            ),
            color: Colors.white,
          ),
          height: 100,
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
                width: MediaQuery.of(context).size.width * 3 / 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(live.title,
                        maxLines: 3,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14.0)),
                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(live.time,
                                  style: TextStyle(
                                      color: Colors.black26,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0))
                            ],
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(right: 10.0),
                  width: MediaQuery.of(context).size.width * 2 / 5,
                  height: 130,
                  child: FadeInImage.assetNetwork(
                      alignment: Alignment.topCenter,
                      placeholder: 'assets/images/placeholder.jpg',
                      image: live.image,
                      fit: BoxFit.fitHeight,
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height * 1 / 3))
            ],
          ),
        ),
      ),
    );
  }
}
