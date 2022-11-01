import 'package:flutter/material.dart';

InputDecoration textFieldDeco(String hint) {
  return InputDecoration(
    hintText: hint,
    contentPadding: EdgeInsets.all(24),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
  );
}



showSnackx(BuildContext context,String message){
          return ScaffoldMessenger.of(context).showSnackBar(  
            
            SnackBar(duration: Duration(seconds: 10),
              content: Text(message))
            
            
            );

}
