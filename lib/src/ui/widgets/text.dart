// import 'package:flutter/material.dart';
// import 'package:flutter_html_textview_render/html_text_view.dart';

// class TextScrenn extends StatefulWidget {
//   TextScrenn({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _TextScrennState createState() => _TextScrennState();
// }

// class _TextScrennState extends State<TextScrenn> {
//   @override
//   Widget build(BuildContext context) {
//     String html = "<h1 style='text-align: center'>H1 centered</h1>" +
//         "</br></br></br>" +
//         "<h2 style='text-align: right'><strong><a href='http://pixzelle.mx'>Anchor with header</a></strong></h2>" +
//         "</br>" +
//         "<p style='color: #000000'>Hello World after line breaks and with custom color.</p>" +
//         "<h2 style='text-align: right'>H2 aligned to the right with parent color</h2>" +
//         "<p><a href='http://www.pixzelle.mx'>An anchor with the color established in the construction</a></p>" +
//         "<p>This is an example of a <strong><a href='http://pixzelle.mx'>multiline p with various tags</a></strong>, it supports <em>italic</em>," +
//         "<strong>bold</strong>, <em><strong>combinations</strong></em>, <a href='http://www.pixzelle.mx'>anchors</a>.</p><br/>" +
//         "<p>We also can combine <a href='http://pixzelle.mx'><strong><em>Anchors with bold and italic</em></strong></a>." +
//         "<p style='text-align: center; color: #00FF00'>" +
//         "For styles, for the moment only text-alignment(left, center and right) and color for the font(HEX: #00FF00)." +
//         "</p>";
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Container(
//           margin: EdgeInsets.all(16.0),
//           child: HtmlTextView(
//             data: "<div style='color: #0000ff'>$html</div>",
//             anchorColor: Color(0xFFFF0000),
//           )),
//     );
//   }
// }