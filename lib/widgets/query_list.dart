import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:idyll/providers/query.dart';
import '../screens/query_screen.dart';

class QueryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final queryState = Provider.of<Query>(context);
    List<String> queries = queryState.queries;

    return Container(
      child: Column(
        children: queries.map((query) {
          return Column(children: [
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .popAndPushNamed(QueryScreen.routeName, arguments: query);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: AutoSizeText(
                      query,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Provider.of<Query>(context, listen: false)
                          .deleteQuery(query);
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 10)
          ]);
        }).toList(),
      ),
    );
  }
}
