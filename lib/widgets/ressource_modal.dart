import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idyll/providers/favorite.dart';
import 'package:idyll/providers/news.dart';
import 'package:idyll/widgets/regular_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RessourceModal extends StatelessWidget {
  final Article article;
  final bool isFavorite;

  RessourceModal(this.article, this.isFavorite);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          article.urlToImage != null
              ? Container(
                  height: 280,
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
                )
              : SizedBox(height: 1),
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
                    ),
                    SizedBox(width: 10),
                    isFavorite
                        ? CircleAvatar(
                            backgroundColor: Color.fromRGBO(211, 211, 211, 100),
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                Navigator.pop(context);
                                Provider.of<Favorite>(context, listen: false)
                                    .deleteArticle(article);
                              },
                              color: Colors.black,
                              iconSize: 16,
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: Color.fromRGBO(211, 211, 211, 100),
                            child: IconButton(
                              icon: Icon(Icons.bookmark),
                              onPressed: () {
                                Provider.of<Favorite>(context, listen: false)
                                    .addNewsArticle(article);
                              },
                              color: Colors.black,
                              iconSize: 16,
                            ),
                          )
                  ],
                ),
                RegularButton("Read article", () {
                  _launchURL(article.url);
                })
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: AutoSizeText(
              "${article.provider}  •  ${DateFormat('MMM.dd,yyyy').format(article.publishedAt)}  •  ${DateFormat.jm().format(article.publishedAt)}  •  ${article.category}",
              style: GoogleFonts.domine(
                textStyle: TextStyle(color: Colors.black, fontSize: 12),
              ),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              minFontSize: 12,
            ),
          ),
          SizedBox(height: 15),
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
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(article.description),
          )
        ],
      ),
    );
  }
}
