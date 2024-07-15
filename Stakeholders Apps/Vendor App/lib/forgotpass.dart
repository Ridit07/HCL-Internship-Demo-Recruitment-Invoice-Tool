import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String textFieldValue = '';
String textFieldValue2 = '';

class forgotpass extends StatefulWidget {
  @override
  _forgotpassState createState() => _forgotpassState();
}

class _forgotpassState extends State<forgotpass> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false, // Disable back button
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 118, 40, 300),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff151515),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 169),
                        width: double.infinity,
                        child: Text(
                          'WELCOME',
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
                        // idTpD (1:3)
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
                        child: Text(
                          'ID:',
                          style: GoogleFonts.inter(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            height: 1.2125,
                            color: Color(0xfffff9f9),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 29),
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
                            // Handle the "LOG IN" button tap
                            // You can access the values of both text fields here
                            print('Text Field 1 Value: $textFieldValue');
                            print('Text Field 2 Value: $textFieldValue2');
                           // Navigator.push(context,MaterialPageRoute(builder:(context)=> homepage()));
                            if(textFieldValue2=='') {

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'Enter Valid Id'),
                              ));
                            }
                            else{


                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'Password reset link has been sent to your mail id'),
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: Size(350, 50),
                          ),
                          child: Text(
                            'Reset',
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
            ),
          );
        },
      ),
    );
  }
}
