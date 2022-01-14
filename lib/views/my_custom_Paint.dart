import 'dart:math';

import 'package:flutter/material.dart';

class MyCustomPaintSignIn extends CustomPainter {
  Paint? my_painter;
  final PageController pageController;

  MyCustomPaintSignIn({required this.pageController})
      : super(repaint: pageController) {
    my_painter = Paint();
    my_painter!.color = Colors.white;
    my_painter!.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (pageController != null && pageController.position != null) {
      ///le radius qui sera sur 20. Comme l'élément peint aura une hauteur de 40, pour ainsi obtenir des bords bien ronds.
      ///le AxeY_Height: qui sera la position y. La hauteur du container étant de 50, pour être bien au milieu. donc 25
      ///le axeXGauche: 25. la position minimum x au départ  (si notre page est à 0).
      ///le AxeXDroite: la position maximum x cible.
      /// La moitié de 300
      final radius = 20.0;
      final AxeY_Height = 25.0;
      final axeXGauche = 25.0;
      final AxeXDroite = 125.0;

      ///La position. C'est la position de notre pageController.
      ///Je récupère ainsi des valeurs par rapport à sa ScrollPositionWithSingleContext, sa direction, sa position par rapport au ViewportDimension (La zone visuel du scroll lateral) et son axe de déroulement.
      ///Le extent: je récupére une valeur qui sera la valeur max de pixels, moins la valeur minimum de pixels à laquelle nous ajouterons les dimensions du viewport.
      ///Ensuite j'obtiens un offset en divisant le extentBefore(qui est la quantité de contenu visible du viewport dans notre élément déroulant) par rapport à la
      ///valeur entent créée.
      final positionPageController = pageController.position;
      final extent = (positionPageController.maxScrollExtent -
          positionPageController.minScrollExtent +
          positionPageController.viewportDimension);
      final offset = positionPageController.extentBefore / extent;

      ///CustomPain est-il à droite alors je le déplace à gauche
      bool isToRight = axeXGauche < AxeXDroite;

      ///Ensuite  je crée des offset(point en 2D), l'entrée et la cible.

      Offset cibleOffset =
          Offset(isToRight ? AxeXDroite : axeXGauche, AxeY_Height);
      Offset DepartOffset =
          Offset(isToRight ? axeXGauche : AxeXDroite, AxeY_Height);

      ///Ces offsets étant créés, je dessiner, en créant un Path. Le path étant un ensemble de ligne droites, courbes....

      ///Je cree mon painter
      ///  _____________
      /// (_____________)
      Path myFormPath = Path();

      ///Pour que notre élément soit arrondi, nous allons d'abord créer un demi cercle (arc),
      ///qui aura pour centre l'offset entry et un radius de 20. l'angle de départ sera de 90° pi étant 180°, pour avoir une courbe de 180°.
      ///Premier arc de cercle sur la gauche (
      myFormPath.addArc(Rect.fromCircle(center: DepartOffset, radius: radius),
          0.5 * pi, 1 * pi);

      ///Rectangle
      ///  _____________
      /// (_____________
      myFormPath.addRect(
        Rect.fromLTRB(cibleOffset.dx, AxeY_Height - radius, DepartOffset.dx,
            DepartOffset.dy + radius),
      );

      ///Second arc de cercle sur la droite )
      ///En general pi c'est 180° - Start angle 270 ==> 180
      myFormPath.addArc(Rect.fromCircle(center: cibleOffset, radius: radius),
          1.5 * pi, 1 * pi);

      /// "peindre la toile"
      /// en faisant canvas.translate. je traduis mon canvas, par rapport à notre offset.
      /// Ici pas de traduction de mots, mais plutot de localization dans les applications.
      canvas.translate(size.width * offset, 0.0);

      /// Création d'une ombre sur le canvas pour donner un effet de hauteur , par rapport au path, avec une couleur, une élévation et un occulter de transparence.
      canvas.drawShadow(myFormPath, Colors.amber, 2.5, true);

      ///Il ne reste plus qu'a  dessiner le path avec la méthode drawPath et avec comme style de dessin my_painter initialisé dans le constructeur.
      canvas.drawPath(myFormPath, my_painter!);
    }
  }

  ///Cet override est appellé à chaque fois qu'une nouvelle instance du CustomPainter
  ///delegate est donnée. Si la réponse est vraie, la fonction saint sera appellée.
  ///Pour l'utilisation continu il que ce soit toujours vrai.
  @override

  ///Par rapport à MyCustomPaintSignIn
  bool shouldRepaint(MyCustomPaintSignIn oldDelegate) {
    return true;
  }
}
