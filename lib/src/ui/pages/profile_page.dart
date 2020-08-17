import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * (40 / 100),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                      child: Card(
                        elevation: 5.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: Colors.purple[800],
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1522529599102-193c0d76b5b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: Colors.white,
                              width: 8.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Yanky Jay Chris',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '@jaychris',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 45,
                      child: FlatButton(
                        color: Colors.purple[800],
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.green[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          /*...*/
                        },
                        child: Text(
                          "Get premium - 500 RWF/mon",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    buildprofileDetail('Email', "thismyemail@gmail.com"),
                    SizedBox(height: 8.0),
                    buildprofileDetail('Country', "Rwanda"),
                    SizedBox(height: 8.0),
                    buildprofileDetail('City', "kigali"),
                    SizedBox(height: 30.0),
                    buildprofileDetail('Bookmarks', "12"),
                    SizedBox(height: 8.0),
                    buildprofileDetail('Favolite writers', "4"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildprofileDetail(String prop, String data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '$prop:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              data,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
