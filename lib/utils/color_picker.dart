import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future colorPickerDialog(BuildContext context, Color pickerColor) async{
  return showDialog<Color>(

    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: pickerColor,
          onColorChanged: (c){
            pickerColor = c;
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0)),
              padding: const EdgeInsets.only(
                  left: 30.0, top: 0.0, right: 30.0, bottom: 0.0)),
          onPressed: () {
            Navigator.of(context).pop(pickerColor);
          },
          child: const Text('CLOSE', style: TextStyle(color: Colors.blue)),
        ),
      ],
    ),
  );
}