import 'package:flutter/material.dart';

class Error404Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/image_whops.png",
          fit: BoxFit.cover,
        ),
        // Positioned(
        //   bottom: MediaQuery.of(context).size.height * 0.15,
        //   left: MediaQuery.of(context).size.width * 0.3,
        //   right: MediaQuery.of(context).size.width * 0.3,
        //   child: FlatButton(
        //     color: Theme.of(context).primaryColor,
        //     shape:
        //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        //     onPressed: () {},
        //     child: Text(
        //       "Retry".toUpperCase(),
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
