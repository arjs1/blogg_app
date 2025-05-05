import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_connection_project/core/firebase/AuthServices/auth_services.dart';
import 'package:firebase_connection_project/core/firebase/DatabaseServices/blog_database.dart';
import 'package:firebase_connection_project/pages/CreatePage/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// title': title,
//       'description': description,
//       'category': category,
//       // 'coverImageUrl': coverImageUrl ?? '',
//       'userId': userId,
//       'username': username,
//       'likesCount': 0,
//       'uploadedAt': timestamp,
class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final List<String> categories = [
    'Technology',
    'Travel',
    'Lifestyle',
    'Fashion',
    'News',
    'Food',
    'Finance',
    'Music',
    'Marketing',
    'Movies',
    'Politics',
  ];

  String? selectedCategory;
  void submitToDatabase(
      String title, String description, String category) async {
    try {
      await BlogDatabase().createBlog(
          title: title,
          description: description,
          category: category,
          userId: Provider.of<AuthServices>(context, listen: false).uid ?? "",
          username: "aryanj");
      setState(() {
        titleController.clear();
        descriptionController.clear();
        selectedCategory = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Successfully Uploaded",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 19),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        child: ListView(
          children: [
            Text(
              "Create a blog".toUpperCase(),
              style: GoogleFonts.bebasNeue(
                color: Colors.black,
                fontSize: 50,
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormFieldWidget(
                  maxLines: 1,
                  controller: titleController,
                  containerName: "Enter a Title",
                ),
                TextFormFieldWidget(
                  maxLines: 8,
                  controller: descriptionController,
                  containerName: "Description",
                ),
                Text(
                  "Category",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                DropdownButtonFormField<String>(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Select Category',
                    labelStyle: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    fillColor: Theme.of(context).colorScheme.tertiary,
                    filled: true,
                  ),
                  value: selectedCategory,
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                    print('Selected Category: $selectedCategory');
                  },
                  validator: (value) =>
                      value == null ? 'Please select a category' : null,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: MaterialButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  if (titleController.text == "" ||
                      descriptionController.text == "" ||
                      selectedCategory == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "All Fields Are Required",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 19),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    submitToDatabase(
                      titleController.text,
                      descriptionController.text,
                      selectedCategory.toString(),
                    );
                  }
                },
                child: Text(
                  "Publish",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
