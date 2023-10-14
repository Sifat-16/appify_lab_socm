import 'package:flutter/material.dart';

import '../text_field_criteria_check.dart';

class CriteriaTextField extends StatelessWidget {
  CriteriaTextField({super.key, this.heading, this.labelText, this.criteria, required this.controller, required this.onChanged});
  Widget? heading;
  String? labelText;
  List<TextFieldCriteriaCheck>? criteria;
  TextEditingController controller;
  Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          if(heading!=null)
            Column(
              children: [
                heading!,
                const SizedBox(height: 10,),
              ],
            ),

          TextFormField(
            onChanged: (s){
              onChanged(s);
            },
            controller: controller,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: labelText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )
            ),
          ),


          if(criteria!=null)
            Column(
              children: [
                SizedBox(height: 10,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [

                      ...List.generate(criteria!.length, (index) {
                        TextFieldCriteriaCheck tc = criteria![index];
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: tc.succeed==true?Colors.green :Colors.transparent,
                                      border: Border.all(
                                          color: tc.succeed==true?Colors.transparent :Colors.grey.shade600
                                      )
                                  ),
                                  child: Center(child: Icon(Icons.check, color: Colors.white, size: 15,)),

                                ),

                                const SizedBox(width: 5,),
                                Expanded(
                                    child: Text(
                                      tc.criteria,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade600
                                      ),
                                    )
                                )
                              ],
                            ),

                            const SizedBox(height: 10,),
                          ],
                        );

                      })

                    ],
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
