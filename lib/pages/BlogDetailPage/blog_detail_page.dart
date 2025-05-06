import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_connection_project/core/const/capitalize_data.dart';
import 'package:firebase_connection_project/core/provider/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BlogDetailPage extends StatefulWidget {
  final blog;
  const BlogDetailPage({super.key, required this.blog});

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  @override
  Widget build(BuildContext context) {
    final uploadedAt = (widget.blog["uploadedAt"] as Timestamp).toDate();
    final formattedDate = DateFormat.yMMMMd().format(uploadedAt);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
              widget.blog["title"].toString().toTitleCase,
              style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.blog["username"].toString().toTitleCase,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 2,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(width: 10),
                Text(
                  formattedDate,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 2,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(width: 10),
                Text(
                  widget.blog["category"].toString().toCapitalized,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      StreamBuilder(
                        stream:
                            PageProvider().isBlogLiked(widget.blog["blogId"]),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          final isLiked = snapshot.data ?? false;
                          return IconButton(
                            onPressed: () {
                              PageProvider().toggleLike(widget.blog["blogId"]);
                            },
                            icon: isLiked
                                ? Icon(
                                    Icons.favorite,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                          );
                        },
                      ),
                      StreamBuilder(
                        stream:
                            PageProvider().blogLikeCount(widget.blog["blogId"]),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          final count = snapshot.data ?? 0;

                          return Text(
                            count.toString(),
                            style: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 17,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                  stream:
                      PageProvider().isBlogBookmarked(widget.blog["blogId"]),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    final isBookmarked = snapshot.data ?? false;
                    return SizedBox(
                      child: isBookmarked
                          ? MaterialButton(
                              elevation: 0,
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: () {
                                PageProvider()
                                    .toggleBookmark(widget.blog["blogId"]);
                              },
                              child: Row(
                                spacing: 8,
                                children: [
                                  Icon(
                                    Icons.bookmark_added,
                                  ),
                                  Text(
                                    "Bookmarked",
                                    style: GoogleFonts.poppins(),
                                  )
                                ],
                              ))
                          : MaterialButton(
                              elevation: 0,
                              color: Theme.of(context).colorScheme.tertiary,
                              onPressed: () {
                                PageProvider()
                                    .toggleBookmark(widget.blog["blogId"]);
                              },
                              child: Row(
                                spacing: 8,
                                children: [
                                  Icon(Icons.bookmark_add_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Bookmark",
                                    style: GoogleFonts.poppins(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
            Divider(
              thickness: 0.6,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Text(
              widget.blog["description"].toString().toCapitalized,
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
                wordSpacing: 1.0,
                height: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
