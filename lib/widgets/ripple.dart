import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:odev2_animation/widgets/circle.dart';

/*Kendisi iç içe 3 daireden oluşacak ve bu dairelerin boyutlarını belli oranlarda değiştirerek doğal bir yayılma animasyonu oluşturacak.*/

class Ripple extends StatefulWidget {
  Ripple(this.diameter, {this.child});

  final double diameter;
  final Widget child;
  _State createState() => new _State(diameter, child);
}

class _State extends State<Ripple> with SingleTickerProviderStateMixin {
  _State(this.diameter, this.child);
  Animation<double> animation;
  AnimationController controller;
  final double diameter;
  final Widget child;

  initState() {
    super.initState();
    controller = new AnimationController(
        //Aşağıdaki satır ile 5 saniyelik bir animasyonu kontrol edecek controller oluşturuyoruz
        duration: const Duration(milliseconds: 5000),
        vsync: this);
    //Şimdi animasyonu oluşturup onu kontrol edecek controller ile bağlamalıyım.
    animation = new Tween(begin: 0.0, end: diameter * 1.7).animate(controller);
    //Animasyon her işlediğinde ekranda gerekli değişiklikleri tetiklemesi için boş state atayan bir listener tanımlıyorum
    animation.addListener(() {
      setState(() {});
    });
    //Animasyonun bitmesini istemediğimden tekrar başlamasını sağlayacak bir kod
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.repeat();
      }
    });
    controller.forward();
  }

  Widget build(BuildContext context) {
    //Başlangıç olarak animation.value'yu kullanarak 3 adet çap değeri hesaplıyorum
    double d1 = (animation.value).clamp(00, diameter).toDouble();
    double d2 =
        (animation.value - diameter * 0.33).clamp(0, diameter).toDouble();
    double d3 =
        (animation.value - diameter * 0.7).clamp(0, diameter).toDouble();
    //Şimdi genişleyen dairelerin renginin silikleşmesini sağlayabilmek adına yine bir hesaplama ile saydamlık yani alpha değerlerini hesaplıyorum.
    int dInt = diameter.toInt();
    int a1 = (dInt - d1.toInt()).clamp(0, 50);
    int a2 = (dInt - d2.toInt()).clamp(0, 50);
    int a3 = (dInt - d3.toInt()).clamp(0, 50);
    // Hesapladığım değerleri iç içe kullanarak üç daireyi kullanıyorum ve son olarak hepsinin üstüne gelecek şekilde dışarıdan verilen TextWidget’imi yerleştiriyorum
    return Container(
        width: diameter,
        height: diameter,
        child: Stack(children: [
          Center(
              child: Circle(
                  diameter: d1,
                  color: Colors.white.withAlpha(a1),
                  child: Circle(
                      diameter: d2,
                      color: Colors.white.withAlpha(a2),
                      child: Circle(
                        diameter: d3,
                        color: Colors.white.withAlpha(a3),
                      )))),
          Center(child: child)
        ]));
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
