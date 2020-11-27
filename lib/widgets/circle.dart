import 'package:flutter/material.dart';

/*lib/widgets klasörünün altına alacağım. Şimdi yazacağım animasyon widget'i bir container
olacak ve içerisinde yazdığımız text'in etrafında bir su dalgasına benzetebileceğimiz daireler çizecek.*/

/*Flutter ile güzel bir daire oluşturmakla başlayalım. Bu daireyi farklı yerlede tekrar kullanabileceğimi
düşünerek widget klasöründe oluşturuyorum.*/

// Kendisi StatelessWidget yani sadece çizimle alakalı kodları içeriyor ve
// içerisinde herhangi bir durum bilgisi yok. İçerisine 3 adet bilgi alıyor (diameter, color ve child).
@immutable
class Circle extends StatelessWidget {
  Circle({this.diameter, this.color, this.child});
  final double diameter;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      width: this.diameter,
      height: this.diameter,
      decoration: new BoxDecoration(shape: BoxShape.circle, color: this.color),
      child: this.child,
    );
  }
}
