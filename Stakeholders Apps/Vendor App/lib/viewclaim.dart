import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(viewclaim());
}

class viewclaim extends StatefulWidget {
  @override
  _viewclaimState createState() => _viewclaimState();
}

class _viewclaimState extends State<viewclaim> {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: Container(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(19, 86, 19, 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff000000),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 149),
                          width: double.infinity,
                          child: Text(
                            'CLAIMS STATUS',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              height: 1.2125,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: GoogleFonts.inter(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                height: 1.2125,
                                color: Color(0xffffffff),
                              ),
                              children: [
                                TextSpan(text: 'Status '),
                                TextSpan(
                                  text: 'Upload Invoice',
                                  style: GoogleFonts.inter(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2125,
                                    color: Color(0xff00ff0a),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 31),
                          child: Text(
                            'vendor ID: 00',
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              height: 1.2125,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 22),
                          child: Text(
                            'Person ID: 00',
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              height: 1.2125,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 220),
                          child: Text(
                            'Person Name: abc',
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              height: 1.2125,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 0,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
