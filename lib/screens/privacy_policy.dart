import 'package:flutter/material.dart';
import 'package:nwewew/screens/setting.dart';


class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Setting()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Privacy Policy",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text("Last Update on 24 Sept, 2021"),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              color: Color(0xffECECEC),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Text(
                    "Help protect your website and its"
                        " users with clear and fair website terms and conditions."
                        " These terms and conditions for a website set out key issues"
                        " such as acceptable use, privacy, cookies, registration and passwords,"
                        " intellectual property, links to other sites, termination and disclaimers of"
                        " responsibility. Terms and conditions are used and necessary to protect a website"
                        " owner from liability of a user relying on the information or the goods provided from the"
                        " site then suffering a loss.Help protect your website and its users with clear and fair website terms"
                        " and conditions. These terms and conditions for a website set out key issues such as acceptable use, privacy,"
                        " cookies, registration and passwords, intellectual property, links to other sites, termination and disclaimers of responsibility."
                        " Terms and conditions are used and necessary to protect a website owner from liability of a user relying on the information or the goods"
                        " provided from the site then suffering a loss.Help protect your website and its users with clear and fair website terms and conditions. These "
                        "terms and conditions for a website set out key issues such as acceptable use, privacy, cookies, registration and passwords, intellectual property, links "
                        "to other sites, termination and disclaimers of responsibility. Terms and conditions are used and necessary to protect a website owner from liability of a user"
                        " relying on the information or the goods provided from the site then suffering a loss.Help protect your website and its users with clear and fair website terms and conditions. These terms and conditions for a website set out key issues such as acceptable use, privacy, cookies, registration and passwords, intellectual property, links to other sites, termination and disclaimers of responsibility. Terms and conditions are used and necessary to protect a website owner from liability of a user relying on the information or the goods provided from the site then suffering a loss.",
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
