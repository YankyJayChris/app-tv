import 'package:flutter/material.dart';
import 'package:newsapp/src/models/slider_model.dart';
import 'package:newsapp/src/repository/local_data.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List<StepModel> list = StepModel.list;
  var _controller = PageController();
  var initialPage = 0;

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() {
        initialPage = _controller.page.round();
      });
    });

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _appBar(),
            _body(_controller),
            _indicator(),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (initialPage > 0)
                _controller.animateToPage(initialPage - 1,
                    duration: Duration(microseconds: 500),
                    curve: Curves.easeIn);
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          FlatButton(
            onPressed: () {
              if (initialPage < list.length)
                _controller.animateToPage(list.length,
                    duration: Duration(microseconds: 500),
                    curve: Curves.easeInOut);
            },
            child: Text(
              "Skip",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _body(PageController controller) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              index == 1
                  ? _displayText(list[index].text)
                  : _displayImage(list[index].url),
              SizedBox(
                height: 25,
              ),
              index == 1
                  ? _displayImage(list[index].url)
                  : _displayText(list[index].text),
            ],
          );
        },
      ),
    );
  }

  _indicator() {
    return Container(
      width: 90,
      height: 90,
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 90,
              height: 90,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.purple),
                value: (initialPage + 1) / (list.length),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                if (initialPage == list.length - 1) {
                  LocalData prefs = LocalData();
                  prefs.setWelcom(true);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => false);
                } else {
                  _controller.animateToPage(initialPage + 1,
                      duration: Duration(microseconds: 500),
                      curve: Curves.easeIn);
                }
              },
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _displayText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    );
  }

  _displayImage(String name) {
    return Image.asset(
      "assets/images/$name",
      height: MediaQuery.of(context).size.height * .5,
    );
  }
}