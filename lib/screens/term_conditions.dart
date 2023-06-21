import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nwewew/screens/setting.dart';

import '../getx controller /settings_controller.dart';

class TermConditionsScreen extends StatelessWidget {
  TermConditionsScreen({Key? key}) : super(key: key);

  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text("Terms & Conditions"),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Text(
                      "Help protect your website and its users with clear and fair "
                          "website terms and conditions. These terms and conditions for "
                          "a website set out key issues such as acceptable use, privacy, cookies,"
                          " registration and passwords, intellectual property, links to other sites, "
                          "termination and disclaimers of responsibility. Terms and conditions are used and "
                          "necessary to protect a website owner from liability of a user relying on the information "
                          "or the goods provided from the site then suffering a loss.",
                    ),
                  ),
                ),
                color: Color(0xffECECEC),
                width: MediaQuery.of(context).size.width,
                height: 147,
              ),
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
                          " relying on the information or the goods provided from the site then suffering a loss.Help protect your website and its users with clear and fair website terms and conditions. "
                          "These terms and conditions for a website set out key issues such as acceptable use, privacy, cookies, registration and passwords, intellectual property, links to other sites, "
                          "termination and disclaimers of responsibility. Terms and conditions are used and necessary to protect a website owner from liability of a user relying on the information or the goods provided from the site then suffering a loss.",
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
