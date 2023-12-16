import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wealth_wizard/view/balance.dart';

// ignore: must_be_immutable
class HomeBackground extends StatefulWidget {
  String username;
  String file;
  HomeBackground({super.key, required this.username, required this.file});

  @override
  State<HomeBackground> createState() => _HomeBackgroundState();
}

class _HomeBackgroundState extends State<HomeBackground> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final storedUsernameBox = await Hive.openBox('username_box');
      final storedImageBox = await Hive.openBox('image_box');

      final storedUsername = storedUsernameBox.get('username');
      final storedImagePath = storedImageBox.get('imagePath');
      if (storedUsername != null) {
        setState(() {
          widget.username = storedUsername;
        });
      }
      if (storedImageBox != null) {
        setState(() {
          widget.file = storedImagePath;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenHeight = size.height;

    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * 0.3,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 95, 13, 109),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: FileImage(File(widget.file)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 55, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Hi ,${widget.username}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 224, 223, 223)),
                              ),
                            ],
                          ),
                          // Text(
                          //   'Welcome back!',
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w500,
                          //       fontSize: 19,
                          //       color: Color.fromARGB(255, 224, 223, 223)),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.15),
            child: Container(
              height: 170,
              width: 320,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(33, 48, 48, 0.294),
                    offset: Offset(0, 6),
                    blurRadius: 12,
                    spreadRadius: 6,
                  ),
                ],
                color: const Color.fromARGB(255, 95, 13, 109),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Total Balance',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text('₹ ${IncomeAndExpence().total()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor:
                                  Color.fromARGB(255, 134, 34, 151),
                              child: Icon(
                                Icons.arrow_upward,
                                color: Colors.white,
                                size: 19,
                              ),
                            ),
                            SizedBox(width: 7),
                            Text('Income',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 216, 216, 216),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor:
                                  Color.fromARGB(255, 134, 34, 151),
                              child: Icon(
                                Icons.arrow_downward,
                                color: Colors.white,
                                size: 19,
                              ),
                            ),
                            SizedBox(width: 7),
                            Text('Expense',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 216, 216, 216),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('₹ ${IncomeAndExpence().income()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                                color: Color.fromARGB(255, 71, 192, 75))),
                        Text(
                          '₹ ${IncomeAndExpence().expense()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 19,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
