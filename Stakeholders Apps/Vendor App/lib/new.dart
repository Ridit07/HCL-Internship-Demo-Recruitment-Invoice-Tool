import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

TextEditingController dateController = TextEditingController();



bool isFilterVisible = false;

void main() {
  runApp(new1());
}

String textFieldValue = '';
String textFieldValue2 = '';

class new1 extends StatefulWidget {
  @override
  _new1State createState() => _new1State();
}


class _new1State extends State<new1> {

  String textFieldValue = '';
  String textFieldValue2 = '';
  String filePath = '';
  bool isFileUploaded = false;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null) {
      setState(() {
        filePath = result.files.single.path!;
        isFileUploaded = true;
      });
    } else {
      // User canceled the file picking
      // Handle accordingly
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    // If a date is picked, update the text field with the selected date
    if (picked != null && picked != dateController.text) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: () {
          setState(() {
            isFilterVisible = false;
          });
        },

        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
            children: [

              Container(
                // maskgroupk7T (0:3)
                width:  double.infinity,
                height:  952,
                child:
                Container(
                  // iphone14pro3G5o (0:4)
                  padding:  EdgeInsets.fromLTRB(25, 54, 25, 0),
                  width:  double.infinity,
                  height:  double.infinity,
                  decoration:  BoxDecoration (
                    color:  Color(0xff151515),
                  ),
                  child:
                  Column(
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children:  [
                      Container(
                        // raiseanewclaimvw3 (0:15)
                        margin:  EdgeInsets.fromLTRB(0, 0, 0, 70),
                        width:  double.infinity,
                        child:
                        Text(
                          'RAISE A NEW CLAIM',
                          textAlign:  TextAlign.center,
                          style:  GoogleFonts.inter (
                            // 'Inter',
                            fontSize:  35,
                            fontWeight:  FontWeight.w400,
                            height:  1.2125,
                            color:  Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        // personid1Sh (0:5)
                        margin:  EdgeInsets.fromLTRB(6, 0, 0, 11),
                        child:
                        Text(
                          'PERSON ID:',
                          style:  GoogleFonts.inter (
                            // 'Inter',
                            fontSize:  25,
                            fontWeight:  FontWeight.w400,
                            height:  1.2125,
                            color:  Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        // rectangle1vpZ (0:7)
                        margin:  EdgeInsets.fromLTRB(6, 0, 0, 20),
                        width:  295,
                        height:  45,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter your text', // Placeholder text
                            border: OutlineInputBorder(),
                            fillColor: Color(0xffd9d9d9), // Box background color
                            filled: true, // This makes the box fill with the background color
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Text padding inside the box
                          ),
                          onSubmitted: (value) {
                            // When the user submits the text field, store the value
                            setState(() {
                              textFieldValue2 = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        // dateofrecruitmentGNd (0:6)
                        margin:  EdgeInsets.fromLTRB(6, 0, 0, 11),
                        child:
                        Text(
                          'Date of Recruitment:',
                          style:  GoogleFonts.inter (
                            // 'Inter',
                            fontSize:  25,
                            fontWeight:  FontWeight.w400,
                            height:  1.2125,
                            color:  Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        // autogroupwfehzpR (QVNaVjDdd9VdWQTydNWfEH)
                        margin: EdgeInsets.fromLTRB(6, 0, 0, 20),
                        width: 295,
                        height: 45,
                        child: TextFormField(
                          controller: dateController,
                          readOnly: true, // Disable manual editing
                          onTap: () {
                            // When the text field is tapped, show the date picker
                            _selectDate(context);
                          },
                          decoration: InputDecoration(
                            hintText: 'Select date',
                            border: OutlineInputBorder(),
                            fillColor: Color(0xffd9d9d9),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                      Container(
                        // vendorid3Xo (0:10)
                        margin:  EdgeInsets.fromLTRB(6, 0, 0, 11),
                        child:
                        Text(
                          'Vendor ID:',
                          style:  GoogleFonts.inter (
                            // 'Inter',
                            fontSize:  25,
                            fontWeight:  FontWeight.w400,
                            height:  1.2125,
                            color:  Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        // rectangle1vpZ (0:7)
                        margin:  EdgeInsets.fromLTRB(6, 0, 0, 20),
                        width:  295,
                        height:  45,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(

                            hintText: 'Enter your text', // Placeholder text
                            border: OutlineInputBorder(),
                            fillColor: Color(0xffd9d9d9), // Box background color
                            filled: true, // This makes the box fill with the background color
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Text padding inside the box
                          ),
                          onSubmitted: (value) {
                            // When the user submits the text field, store the value
                            setState(() {
                              textFieldValue2 = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        // personskill7nZ (0:17)
                        margin:  EdgeInsets.fromLTRB(6, 0, 0, 11),
                        child:
                        Text(
                          'PERSON Skill:',
                          style:  GoogleFonts.inter (
                            // 'Inter',
                            fontSize:  25,
                            fontWeight:  FontWeight.w400,
                            height:  1.2125,
                            color:  Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        // rectangle1vpZ (0:7)
                        margin:  EdgeInsets.fromLTRB(6, 0, 0, 20),
                        width:  295,
                        height:  45,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter your text', // Placeholder text
                            border: OutlineInputBorder(),
                            fillColor: Color(0xffd9d9d9), // Box background color
                            filled: true, // This makes the box fill with the background color
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Text padding inside the box
                          ),
                          onSubmitted: (value) {
                            // When the user submits the text field, store the value
                            setState(() {
                              textFieldValue2 = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        // personxpCZ7 (0:8)
                        margin:  EdgeInsets.fromLTRB(3, 0, 0, 11),
                        child:
                        Text(
                          'PERSON XP:',
                          style:  GoogleFonts.inter (
                            // 'Inter',
                            fontSize:  25,
                            fontWeight:  FontWeight.w400,
                            height:  1.2125,
                            color:  Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        // rectangle1vpZ (0:7)
                        margin:  EdgeInsets.fromLTRB(6, 0, 0, 20),
                        width:  295,
                        height:  45,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter your text', // Placeholder text
                            border: OutlineInputBorder(),
                            fillColor: Color(0xffd9d9d9), // Box background color
                            filled: true, // This makes the box fill with the background color
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Text padding inside the box
                          ),
                          onSubmitted: (value) {
                            // When the user submits the text field, store the value
                            setState(() {
                              textFieldValue2 = value;
                            });
                          },
                        ),
                      ),


                      Positioned(
                        bottom: 50,
                        left: MediaQuery.of(context).size.width / 2 - 175,
                        child: ElevatedButton(
                          onPressed: () {
                            _pickFile();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: isFileUploaded ? Colors.green : Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: Size(350, 50),
                          ),
                          child: Text(
                            isFileUploaded ? 'FILE UPLOADED' : 'UPLOAD FILE',
                            style: GoogleFonts.inter(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              height: 1.2125,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                      Text("\n"),
                      Positioned(
                        bottom: 10,
                        left: MediaQuery.of(context).size.width / 2 - 175,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add functionality for the second button here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: Size(350, 50),
                          ),
                          child: Text(
                            'SUBMIT',
                            style: GoogleFonts.inter(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              height: 1.2125,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
