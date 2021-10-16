// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/ui/home/store/home_store.dart';
import 'package:finneasy/src/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class BlogCreateForm extends StatefulWidget {
  final HomeStore store;
  const BlogCreateForm({Key? key, required this.store}) : super(key: key);

  @override
  _BlogCreateFormState createState() => _BlogCreateFormState();
}

class _BlogCreateFormState extends State<BlogCreateForm> {
  final _pomodoroPopUpFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  TextEditingController bodyController = TextEditingController();
  FocusNode bodyFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return AlertDialog(
      content: Form(
        key: _pomodoroPopUpFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Add Blog",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight* 0.035),
              child: CustomTextFormField(
                controller: titleController,
                focusNode: titleFocusNode,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: "Title",
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight* 0.035),
              child: CustomTextFormField(
                controller: bodyController,
                focusNode: bodyFocusNode,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: "Body",
              ),
            ),
            SizedBox(height: screenHeight*0.01,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).focusColor)
                ),
                child: Text(
                  "Post",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  widget.store.blogCreate(context, titleController, bodyController);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}