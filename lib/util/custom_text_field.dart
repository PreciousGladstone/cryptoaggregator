import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.onChanged, required this.text});

  final void Function(String value) onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      
      
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 13, bottom: 12),
        prefixIcon: Icon(Icons.search, color: Color(0xFFDFE2E4), size: 34,),
        
        hintText: text,
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Color(0xFFDFE2E4),
          fontSize: 16
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 1,)


        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Color(0xFFDFE2E4),),
        ),
        focusedBorder:  OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xFFDFE2E4), )),
      ),
      onChanged: onChanged,
      
    );
  }
}
