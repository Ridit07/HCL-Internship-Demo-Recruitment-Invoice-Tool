import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(viewclaim());
}
bool showEmployeeDetails = false;
bool showEmployeeDetails2 = false;
bool showEmployeeDetails3 = false;
bool showEmployeeDetails4 = false;

class viewclaim extends StatefulWidget {
  @override
  _viewclaimState createState() => _viewclaimState();
}

class _viewclaimState extends State<viewclaim> {
  List names2 = ["vendor name - abc\n","vendor Email- vendor1@example.com\n","vendor phone- 1234567890\n","PersonSkill- acd\n","Experience- 10 Years\n","PersonDateOfHiring- 2022-01-01\n"];
  List designations2 = ["Person Region- abc","PersonEmailID - person1@example.com","PersonDateOfHiring- 2022-01-01","PersonStatus- Active","ContractDuration- 2 years","PersonDept- abc","PersonSkill- acd","Experience- 10 Years"];
  List status = ["status  ch date   ch By   rejected    manager","  0    2023-08-05     10           0              sv","  0    2023-07-05     7             0              sv","  0    2023-01-05     3             0              sv"];
  List remarks = ["remarks 1\n"," remarks 2"];
  String textFieldValue = '';
  String textFieldValue2 = '';
  String filePath = '';
  bool isFileUploaded = false;
  bool isReferBackVisible = false;



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            body:SingleChildScrollView(
              child:GestureDetector(
                onTap: (){
                 setState(() {
                   isReferBackVisible=false;
                 });

                },
            child:Container(
              height: 1550,
              child: Stack(
                children: [
                  GestureDetector(

                 child: Container(
                    padding: EdgeInsets.fromLTRB(19, 86, 19, 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff000000),
                    ),



                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 19),
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
                                // TextSpan(text: 'Status '),
                                // TextSpan(
                                //   text: 'Upload Invoice',
                                //   style: GoogleFonts.inter(
                                //     fontSize: 25,
                                //     fontWeight: FontWeight.w700,
                                //     height: 1.2125,
                                //     color: Color(0xff00ff0a),
                                //   ),
                                // ),
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
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 32),
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


            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 22),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    //showEmployeeDetails2=false;

                    showEmployeeDetails = !showEmployeeDetails;
                  });
                },
                child: Text(
                  'View Vendor Details?',
                  style: GoogleFonts.inter(
                    decoration: TextDecoration.underline,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    height: 1.2125,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),

                        if (showEmployeeDetails)

                          Positioned(
                            top: 30,
                            left: 30,
                            right: 30,
                            child: Container(
                              height: 180, // Set the desired height for the scrollable container
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListView.builder(
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return Text(
                                    names2[index], // Replace with your desired text
                                    style: TextStyle(fontSize: 16),
                                  );
                                },
                              ),
                            ),
                          ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 22),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                //showEmployeeDetails=false;
                                showEmployeeDetails2 = !showEmployeeDetails2;

                              });
                            },
                            child: Text(
                              'View Details in Employee table?',
                              style: GoogleFonts.inter(
                                decoration: TextDecoration.underline,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                height: 1.2125,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),

                        if (showEmployeeDetails2)
                          Positioned(
                            top: 30,
                            left: 30,
                            right: 30,
                            child: Container(
                              height: 180, // Set the desired height for the scrollable container
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListView.builder(
                                itemCount: 8,
                                itemBuilder: (context, index) {
                                  return Text(
                                    designations2[index] + "\n", // Replace with your desired text
                                    style: TextStyle(fontSize: 16),
                                  );
                                },
                              ),
                            ),
                          ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 22),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                //showEmployeeDetails=false;
                                showEmployeeDetails3 = !showEmployeeDetails3;

                              });
                            },
                            child: Text(
                              'View Details in Status table?',
                              style: GoogleFonts.inter(
                                decoration: TextDecoration.underline,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                height: 1.2125,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),

                        if (showEmployeeDetails3)
                          Positioned(
                            top: 30,
                            left: 30,
                            right: 30,
                            child: Container(
                              height: 180, // Set the desired height for the scrollable container
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListView.builder(
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Text(
                                    status[index] + "\n", // Replace with your desired text
                                    style: TextStyle(fontSize: 16),
                                  );
                                },
                              ),
                            ),
                          ),

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 22),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                //showEmployeeDetails=false;
                                showEmployeeDetails4 = !showEmployeeDetails4;

                              });
                            },
                            child: Text(
                              'View Details in Recovery table?',
                              style: GoogleFonts.inter(
                                decoration: TextDecoration.underline,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                height: 1.2125,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),

                        if (showEmployeeDetails4)
                          Positioned(
                            top: 30,
                            left: 30,
                            right: 30,
                            child: Container(
                              height: 180, // Set the desired height for the scrollable container
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListView.builder(
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return Text(
                                    remarks[index] + "\n", // Replace with your desired text
                                    style: TextStyle(fontSize: 16),
                                  );
                                },
                              ),
                            ),
                          ),

                        Text(""),
                        Positioned(
                          bottom: 0,
                          left: MediaQuery.of(context).size.width / 2 - 175,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('approved'),
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: isFileUploaded ? Colors.green : Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: Size(350, 50),
                            ),
                            child: Text(
                              'APPROVE',
                              style: GoogleFonts.inter(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                height: 1.2125,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Text(""),
                        Positioned(

                          bottom: 0,
                          left: MediaQuery.of(context).size.width / 2 - 175,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('rejected'),
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: isFileUploaded ? Colors.green : Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: Size(350, 50),
                            ),
                            child: Text(
                              'REJECT',
                              style: GoogleFonts.inter(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                height: 1.2125,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Text(""),
                        Positioned(

                          bottom: 0,
                          left: MediaQuery.of(context).size.width / 2 - 175,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isReferBackVisible = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: isFileUploaded ? Colors.green : Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: Size(350, 50),
                            ),
                            child: Text(
                              'Refer Back',
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

            if (isReferBackVisible)
             Container(
            color: Colors.black.withOpacity(0.7),
          child: Center(
          child: Container(

            width: 300,
          height: 300,
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
          "Enter Refer Back Remarks",
          style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          TextFormField(
          onChanged: (value) {
          setState(() {
          textFieldValue = value;
          });
          },
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Type your remarks here",
          ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
          onPressed: () {
          // Hide the overlay and show snackbar on submit
          setState(() {
          isReferBackVisible = false;
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(
          content: Text('Success'),
          ));


          },
          child: Text("Submit"),
          ),
                ],
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
