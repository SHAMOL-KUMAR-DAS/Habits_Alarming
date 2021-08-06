import 'package:flutter/material.dart';
import 'package:jouleslab/home.dart';
import 'package:jouleslab/platform_flat_button.dart';
import 'package:jouleslab/title_message.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    void goToHomeScreen() => Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: deviceHeight * 0.04,
            ),
            Image.asset('assets/images/welcome_image.png',
                width: double.infinity, height: deviceHeight * 0.4),
            SizedBox(
              height: deviceHeight * 0.08,
            ),
            TitleAndMessage(deviceHeight),
            SizedBox(
              height: deviceHeight * 0.03,
            ),
            SizedBox(height: deviceHeight*0.05,),
            Container(
              height: deviceHeight * 0.09,
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                  child: PlatformFlatButton(
                    handler: goToHomeScreen ,
                    color: Theme.of(context).primaryColor,
                    buttonChild: FittedBox(
                      child: Text(
                        "Get started now",
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
