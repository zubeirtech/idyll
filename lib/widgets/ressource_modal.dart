import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idyll/providers/news.dart';
import 'package:idyll/widgets/regular_button.dart';

class RessourceModal extends StatelessWidget {
  final Article article;
  RessourceModal(this.article);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(children: [
            Container(
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child: Image.network(
                  article.urlToImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Column(children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.bookmark_border_outlined),
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: () {},
                    )
                  ],
                ),
              ]),
            )
          ]),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromRGBO(211, 211, 211, 100),
                      child: IconButton(
                        icon: FaIcon(FontAwesomeIcons.facebookF),
                        onPressed: () {},
                        color: Colors.black,
                        iconSize: 16,
                      ),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Color.fromRGBO(211, 211, 211, 100),
                      child: IconButton(
                        icon: FaIcon(FontAwesomeIcons.twitter),
                        onPressed: () {},
                        color: Colors.black,
                        iconSize: 16,
                      ),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Color.fromRGBO(211, 211, 211, 100),
                      child: IconButton(
                        icon: FaIcon(FontAwesomeIcons.share),
                        onPressed: () {},
                        color: Colors.black,
                        iconSize: 16,
                      ),
                    )
                  ],
                ),
                RegularButton("Read article", () {})
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              article.title,
              style: GoogleFonts.domine(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
