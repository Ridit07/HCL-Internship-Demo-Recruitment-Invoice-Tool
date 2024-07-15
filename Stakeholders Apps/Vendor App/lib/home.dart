import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendorapp/main.dart';
import 'package:vendorapp/new.dart';
import 'package:vendorapp/viewclaim.dart';


bool isFilterVisible = false;

void main() {
  runApp(homepage());
}
List names = ["Saige Fuentes","Bowen Higgins ","Leighton Kramer","Kylan Gentry","Amelie Griffith ","Franklin Sierra","Marceline Avila","Jaylen Blackwell","Kaiden Woodard ","Sloane Stevenson","Fernando Cain","Alessandra Parks"];
List designations = ["1","2","3","4","5","6","7","8","9","10","11","12"];
List  status = ["closed","rejeced","refer","closed","refer","closed","rejeced","refer","rejeced","closed","closed","refer"];
List  date = ["10/04/23","12/01/23","22/07/23","20/07/23","19/07/23","15/06/23","17/07/23","15/07/23","12/05/23","09/06/23","05/02/23","30/03/23"];

String textFieldValue = '';
String textFieldValue2 = '';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}



class _homepageState extends State<homepage> {

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
body: Stack(
  children: [
Container(
// iphone14pro15B77 (3:32)
padding:  EdgeInsets.fromLTRB(8, 58, 7, 29),
            width:  double.infinity,
            decoration:  BoxDecoration (
              color:  Color(0xff151515),
            ),
            child:
            Column(
                children:  [
            Container(
            child:
            Row(
              children: [
                Container(
                  margin:  EdgeInsets.fromLTRB(0, 0, 0, 19),
                  child: Row(
                    children:  [

                      GestureDetector(
                        onTap: (){

                          Navigator.push(context,MaterialPageRoute(builder:(context)=> SimpleApp()));

                        },
                      child:Container(
                        // image49TF (3:52)
                        margin:  EdgeInsets.fromLTRB(0, 0, 20, 0),
                        width:  45,
                        height:  44,
                        child:
                        Image.asset(
                          "images/logout.png",
                          fit:  BoxFit.cover,
                        ),
                      ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin:  EdgeInsets.fromLTRB(225, 0, 0, 19),
                  child: Row(
                    children:  [


                      GestureDetector(
                        onTap: (){

                          Navigator.push(context,MaterialPageRoute(builder:(context)=> new1()));

                        },
                        child:Container(
                          // image49TF (3:52)
                          margin:  EdgeInsets.fromLTRB(0, 0, 20, 0),
                          width:  45,
                          height:  44,
                          child:
                          Image.asset(
                            "images/plus.png",
                            fit:  BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        // image5561 (3:53)
                        width:  38,
                        height:  49,
                        child:
                        Image.asset(
                          "images/support.png",
                          fit:  BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ),
          Container(
          // claimstatus2X3 (3:33)
          margin:  EdgeInsets.fromLTRB(0, 0, 0, 40),
          width:  double.infinity,
          child:
          Text(
          'CLAIM STATUS',
          textAlign:  TextAlign.center,
          style:  GoogleFonts.inter (

          fontSize:  40,
          fontWeight:  FontWeight.w400,
          height:  1.2125,
          color:  Color(0xfffffbfb),
          ),
          ),
          ),
          Container(
          // autogroupqdm3VvR (Xxg5dFevLpSHnTUuVxQDm3)
          margin:  EdgeInsets.fromLTRB(0, 0, 13, 0),
          height:  51,
          child:
          Row(
          crossAxisAlignment:  CrossAxisAlignment.center,
          children:  [
          Container(
          // image6Rp5 (3:54)
          margin:  EdgeInsets.fromLTRB(0, 0, 178, 1),
          width:  44,
          height:  44,
          child:
          Image.asset(
          "images/download.png",
          fit:  BoxFit.cover,
          ),
          ),
          Container(
          // image9mN9 (3:58)
          width:  44,
          height:  51,
          child:
          Image.asset(
          "images/refresh.png",
          fit:  BoxFit.cover,
          ),
          ),
          GestureDetector(
            onTap:() {

              setState(() {
                isFilterVisible = !isFilterVisible;
              });
            },
          child:Container(
          // autogroupqxfwujF (Xxg5nVtWqkj4eHQcyMQXFw)
          margin:  EdgeInsets.fromLTRB(0, 14, 0, 9),
          padding:  EdgeInsets.fromLTRB(6.5, 0, 6, 0),
          height:  double.infinity,
          decoration:  BoxDecoration (
          border:  Border.all(color: Color(0xff0019ff)),
          color:  Color(0xffffffff),
          borderRadius:  BorderRadius.circular(30),
          ),
          child:
          Row(
          crossAxisAlignment:  CrossAxisAlignment.center,
          children:  [
          Container(
          // filtersCCZ (3:56)
          margin:  EdgeInsets.fromLTRB(0, 0, 2.5, 3),
          child:
          Text(
          'Filters',
          textAlign:  TextAlign.center,
          style:  GoogleFonts.inter (
          fontSize:  20,
          fontWeight:  FontWeight.w400,
          height:  1.2125,
          color:  Color(0xff000000),
          ),
          ),

          ),
          Container(
          // image7Hzh (3:57)
          margin:  EdgeInsets.fromLTRB(0, 1, 0, 0),
          width:  26,
          height:  13,
          child:
          Image.asset(
          "images/arrow.png",
          fit:  BoxFit.cover,
          ),
          ),
          ],
          ),
          ),
      ),
          ],
          ),
          ),
          ],
          ),
          ),

    Container(
      margin:  EdgeInsets.fromLTRB(0, 265, 0, 0),

      child: ListView.builder (
        itemCount: 12,
        shrinkWrap: true,

        itemBuilder: (BuildContext context, int index) =>

            GestureDetector(
              onTap: (){
                if(isFilterVisible==true){
                  setState(() {
                    isFilterVisible=false;

                  });
                }
                else{
                  Navigator.push(context,MaterialPageRoute(builder:(context)=> viewclaim()));

                }

              },
              child:Container (
                width: MediaQuery.of (context).size.width,
                padding: EdgeInsets.symmetric (horizontal: 10.0, vertical: 5.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius. circular (10.0),
                  ), // Rounded Rectangle Border
                  child: Container(
                    width: MediaQuery.of (context). size.width,
                    padding: EdgeInsets.symmetric (horizontal: 10.0, vertical: 10.0),

                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            SizedBox(width: 5.0,),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text (names[index], style: TextStyle (color: Colors.black, fontSize:
                                18.0, fontWeight: FontWeight.bold)),
                                Text (designations [index], style: TextStyle(color: Colors.grey)),
                              ],

                            ),

                          ],
                        ),
                        Container(
                          alignment: Alignment.center,

                          child: Column(
                         children:[ Text(status[index], style: TextStyle(color: Colors.black)),
                           Text("", style: TextStyle(color: Colors.black)),

                           Text(date[index], style: TextStyle(color: Colors.black))

                         ],
                          ),
                        ),
                      ], // <Widget>[]
                    ), // Row
                  ),
                ),
              ),
            ),
      ),
    ),

        Positioned(
          top: 280,
          left: 16,
          right: 16,
          child: Visibility(
            visible: isFilterVisible,
            child:GestureDetector(
              onTap: (){

              },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 8),
                      Text(
                        'Filter By',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Date',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Name',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'ID',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Group By',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Refer',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Rejected',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'closed',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ),
        ),
  ],
),
          ),
      ),
    );
  }
}
