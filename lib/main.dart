import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scale Transition',
      home: DepthTransition(title: 'Scale Transition'),
      debugShowCheckedModeBanner: false,
    );
  }
}


class DepthTransition extends StatefulWidget {
  DepthTransition({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DepthTransitionState createState() => _DepthTransitionState();
}

class _DepthTransitionState extends State<DepthTransition>
    with SingleTickerProviderStateMixin{
  AnimationController controller;
  final double minZoom = 0.75;
  final double maxZoom = 1;

  @override
  initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ));
    controller = AnimationController(
      value: minZoom,
      vsync: this,
      duration: Duration(seconds: 10),
    );
    controller.addStatusListener((status) {
      Timer(Duration(seconds: 10), () {
        if (status == AnimationStatus.completed) {
          controller.animateBack(minZoom);
        } else if (status == AnimationStatus.dismissed) {
          controller.animateTo(maxZoom);
        }
      });
    });
    controller.animateTo(maxZoom);
  }

  Widget buildItem(int position) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "The Value Of Trust",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            "\nTrust is why you pay higher to a brand than its generic "
                "counterparts. Trust is why you prefer your friend to "
                "be your business partner over someone new but promising. "
                "Trust is also why relationships work or they don’t. "
                "Trust is why a product endorsed by a celebrity sells "
                "in volume. There is a deep value in trust that doesn’t "
                "show up in balance sheet or net worth of a person or "
                "company.\n\nA person who is trustworthy but intellectually "
                "mediocre is often worth more than the person who is highly "
                "intelligent but can’t be trusted.\n\nCountries who are poor, "
                "remain poor because there is low trust among its "
                "inhabitants. Trust facilitates transactions and "
                "transactions facilitates growth.\n\nThere is a trust value "
                "to every person, place or thing. People value trust "
                "because they value predictability.\n\nTherefore, when your "
                "words and actions align, you become predictable, and build "
                "trust. This makes you far more valuable as a person.",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget child) {
            final double value = controller.value;
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..scale(value, value),
              child: child,
            );
          },
          child: buildItem(0),
        ),
      ),
    );
  }
}
