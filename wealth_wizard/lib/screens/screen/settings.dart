import 'package:flutter/material.dart';
import 'package:wealth_wizard/settings/about.dart';
//import 'package:wealth_wizard/settings/privacy_policy.dart';
import 'package:wealth_wizard/settings/reset.dart';
import 'package:wealth_wizard/settings/terms_condition.dart';

class settings extends StatelessWidget {
  const settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromARGB(255, 95, 13, 109),
        title: const Center(
          child: Text(
            'Settings',
            style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SafeArea(
        child: Card(
          child: ListView(
            children: [
              const Divider(
                thickness: 2,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TermsCondition(),
                  ));
                },
                child: const ListTile(
                  title: Text(
                    'Terms and Conditions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const Divider(
                thickness: 3,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const About(),
                  ));
                },
                child: const ListTile(
                  title: Text(
                    'Aboutt',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const Divider(
                thickness: 3,
              ),
              GestureDetector(
                onTap: () {
                  reset().resetApp(context);
                },
                child: const ListTile(
                  title: Text(
                    'Reset',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const Divider(thickness: 3)
            ],
          ),
        ),
      ),
    );
  }
}
