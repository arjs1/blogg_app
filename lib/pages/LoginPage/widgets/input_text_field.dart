import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputTextField extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  TextEditingController? controller;
  // String? Function(String?)? validator;
  final String hinttext;
  final bool obscuretext;
  InputTextField({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.obscuretext,
    // required this.validator, //because validator is not required yet
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool isSetIcon = false;
  void setIcondata() {
    setState(() {
      isSetIcon = !isSetIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: widget.controller,
        cursorColor: Colors.white,
        obscureText: !isSetIcon ? widget.obscuretext : false,
        decoration: widget.obscuretext
            ? InputDecoration(
                hintText: widget.hinttext,
                suffixIcon: IconButton(
                  onPressed: () {
                    setIcondata();
                  },
                  icon: isSetIcon
                      ? Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.white,
                        ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                fillColor: Theme.of(context).colorScheme.primary,
                filled: true,
              )
            : InputDecoration(
                hintText: widget.hinttext,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                fillColor: Theme.of(context).colorScheme.primary,
                filled: true,
              ),
      ),
    );
  }
}
