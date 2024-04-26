import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'component /button.dart';
import 'component /text_field_widget.dart';

class AddPasswordBottomModal {
  static String dropdownValue = "";
 static TextEditingController siteNameController = TextEditingController();
  static void showBottomModal(BuildContext context, ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter changeState) {
              return Padding(
                padding:  const EdgeInsets.only(top: 10, bottom: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:  Radius.circular(10), topRight: Radius.circular(10),)
                  ),
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child:  SingleChildScrollView(
                    child: Column(
                        children:[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Save Your Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
                              ),
                              GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Icon(Icons.close)),
                            ],
                          ),
                          const SizedBox(height: 30,),
                          TextFieldWidget(
                              hintText: 'Enter your email',
                            controller: siteNameController ,
                            textInputType: TextInputType.text,),
                          const SizedBox(height: 10,),
                          TextFieldWidget(
                              hintText: 'Enter your password',
                            controller: siteNameController ,
                            textInputType: TextInputType.text,),
                          const SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            offset: const Offset(0, 4),
                            spreadRadius: 0,
                            blurRadius: 24,
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(width: 1.5, color: Colors.green),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(width: 1.5, color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(width: 1.5, color: Colors.green),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(width: 1.5, color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(width: 1.5, color: Colors.redAccent),
                          ),
                        ),
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          // setState(() {
                          //   dropdownValue = newValue!;
                          // });
                        },
                        items: <String>['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 50,),
                          SubmitButton(isLoading: false, label: 'Save Password', submit: () {  }, color: Colors.green,)



                        ]
                    ),
                  ),
                ),
              );
            }
        );


      },
    );
  }
}