import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EasingAnimation extends StatefulWidget {
  @override
  EasingAnimationState createState() => EasingAnimationState();
}

class EasingAnimationState extends State<EasingAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  //yazının hareketi için bir Animation' a ihtiyacımız var.
  Animation _animation;

  @override
  Widget build(BuildContext context) {
    //mevcut ortamın boyutunu öğrenmek için
    final double width = MediaQuery.of(context).size.width;
    //animasyonu başlatmak için kullanılır.
    _controller.forward();
    return AnimatedBuilder(
        animation: _controller,
        //iki variable içeriyor.bir tanesi animasyon ve animasyon denetleyicisine geçeceğimiz, diğeri de widget a geçeceğimiz builder.
        builder: (BuildContext context, Widget child) {
          return Scaffold(

              //sınıfı dönüştürmek için transform u temel widget alıyoruz.
              //parmetre olarak iki variable alıyor. biri transform diğeri de dönüştürülecek child.
              body: Container(
            //body kısmındaki eyfel için
            decoration: new BoxDecoration(
                image: new DecorationImage(
              image: new AssetImage("assets/images/eyfel.jpg"),
              fit: BoxFit.cover,
            )),
            child: Transform(
              // child i boyamadan önce bir değişim uygulayan widget.
              transform:
                  //translationValues x,y,z yön değerlerini alır.
                  Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
              child: new Center(
                  child: Container(
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                  //animasyondaki eyfel için
                  image: new AssetImage("assets/images/eyfel.jpg"),
                  fit: BoxFit.cover,
                )),
              )),
            ),
          ));
        });
  }

  @override
  void initState() {
    super.initState();

    //vsync sanal senkronizasyon anlamına gelir.
    //animasyonun2 saniye olacağını belirten bir AnimationController koyduk
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    //Tween objesi animasyonun ekranın solundan girip ortada kalacağını belirtir.
    //Tween nesnesini bir animasyonla kullanmak için .animate yöntemi çağrılır.
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ))
      //..addListener işlemi setState işlemini çağırır. animasyon her sayı oluşturduğunda build() metodunu çağırır.
      //..addStatusListener ise animasyonun ne zaman değiştiğini bilmek için kullanılır. durum dinleme gibi.
      //baştaki iki nokta animate işleminden dönen değerle çağrıldığını gösterir.
      ..addStatusListener(handler);
  }

  /*Animasyonun bitmesini istemediğimden tekrar başlamasını sağlayacak bir kod daha yazmalıyım ve sonrasında
  controller’imi başlatarak gerekli tüm initState işlerini bitirmiş oluyorum.*/
  void handler(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(handler);
      _controller.reset();
      _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ))
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            Navigator.pop(context);
          }
        });
      _controller.forward();
    }
  }

  // Görünüm hazır olduğunda, sızıntıları önlemek için kontrol cihazı kaynaklarını serbest bırakmalıyız.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
