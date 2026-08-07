import 'dart:ffi';

import 'package:flutter/material.dart';

class SetProfile extends StatefulWidget {
  const SetProfile({super.key});

  @override
  State<SetProfile> createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFBF8FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome!',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
              ),
              Text(
                'Please Select Your Role To',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
              Text(
                'Continue',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Icon(
                    Icons.business_center_outlined,
                    color: Color(0xff6739C8),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Choose Your Role',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(height: 13),
              //Employee
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Card(
                  elevation: 1.0, // Shadow depth
                  color: Colors.white, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ), // Corner roundness
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            color: Color(0xffE4D5FD),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(Icons.badge_outlined, size: 70),
                          ),
                        ),
                        SizedBox(width: 10),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Employee',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Reserves Seats,',
                                  style: TextStyle(fontSize: 13.0),
                                ),
                                Text(
                                  'Check Availability',
                                  style: TextStyle(fontSize: 13.0),
                                ),
                              ],
                            ),
                            SizedBox(width: 50),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.navigate_next_rounded,
                                size: 50,
                                color: Color(0xff6739C8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              //Admin
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Card(
                  elevation: 1.0, // Shadow depth
                  color: Colors.white, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ), // Corner roundness
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 211, 234, 215),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.admin_panel_settings_outlined,
                              size: 70,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Admin',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Manages Seats,',
                              style: TextStyle(fontSize: 13.0),
                            ),
                            Text(
                              'users, and bookings',
                              style: TextStyle(fontSize: 13.0),
                            ),
                          ],
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
    );
  }
}
