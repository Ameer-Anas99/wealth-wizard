import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 122, 27, 139),
            title: Text(
              "About",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: Center(
            child: Container(
              width: 260,
              height: 300,
              color: Colors.grey,
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 10,
                shadowColor: Colors.white,
                child: Column(
                  children: [
                    Title(
                        color: Colors.black,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 30, left: 10),
                          child: Text(
                            'Wealth Wizard',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 10),
                      child: Text(
                        '"This is an app where you can\nadd your daily transactions\naccording to the category which it belongs to."',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Developed by',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        'Ameer Anas C',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
