// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: camel_case_types, must_be_immutable
class Custom_TextFiled extends StatelessWidget {
  // ignore: non_constant_identifier_names
  Custom_TextFiled.Custom_TextFormFiled(
      {super.key, required this.hintText,required this.controller});

 // Function(String)? onChange;
 TextEditingController controller = TextEditingController();

  String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: TextFormField(
        controller:controller ,
        validator: (data){
          if (data!.isEmpty) {
            return 'Field is required';
          }
        },
        //onChanged: onChange,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Colors.black, width: 2)),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}
