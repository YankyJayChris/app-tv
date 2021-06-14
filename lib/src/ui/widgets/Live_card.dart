import 'package:flutter/material.dart';
import '../../../src/models/live.dart';

class LiveWidgetHor extends StatelessWidget {
  final Live live;
  final Function onTap;

  LiveWidgetHor({this.live, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: MediaQuery.of(context).size.height * (30 / 100),
        padding: EdgeInsets.only(bottom: 10.0),
        child: InkWell(
          onTap: () {
            onTap();
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
                    image: NetworkImage(live.image),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(live.title,
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
              // SizedBox(
              //   width: 5.0,
              // ),
              // Container(
              //   width: MediaQuery.of(context).size.width * (95 / 100),
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         width: MediaQuery.of(context).size.width * (75 / 100),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Container(
              //               child: Text(live.description,
              //                   style: TextStyle(
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.black),
              //                   textAlign: TextAlign.start,
              //                   maxLines: 3),
              //             ),

              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
