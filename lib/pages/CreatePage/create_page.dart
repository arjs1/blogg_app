import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_connection_project/core/firebase/AuthServices/auth_services.dart';
import 'package:firebase_connection_project/core/firebase/DatabaseServices/blog_database.dart';
import 'package:firebase_connection_project/pages/LoginPage/widgets/input_text_field.dart';
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
  TextEditingController categoryController = TextEditingController();

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
        categoryController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Successfully Logged In",
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          InputTextField(
              controller: titleController,
              hinttext: "Title",
              obscuretext: false),
          InputTextField(
              controller: descriptionController,
              hinttext: "Description",
              obscuretext: false),
          InputTextField(
              controller: categoryController,
              hinttext: "Category",
              obscuretext: false),
          MaterialButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              submitToDatabase(titleController.text, descriptionController.text,
                  categoryController.text);
            },
            child: Text("Upload"),
          ),
        ],
      ),
    );
  }
}
