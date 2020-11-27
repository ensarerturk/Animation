import 'package:odev2_animation/pages/easinganimation.dart';
import 'package:odev2_animation/widgets/ripple.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: new BoxDecoration(
          image: new DecorationImage(
        image: new AssetImage("assets/images/info_bg.png"),
        fit: BoxFit.cover,
      )),
      child: Column(
        children: [
          Ripple(
            500,
            child: Text('Info',
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 50.0, color: Colors.white)),
          ),
          //
          //Bir sonraki animasyona geçmek için tıklanabilir bir icon
          RaisedButton.icon(
              onPressed: () {
                //Navigator.of navigator a erişir
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => new EasingAnimation()));
              },
              icon: Icon(Icons.animation),
              label: Text("Easing Animation")),
        ],
      ),
    ));
  }
}
