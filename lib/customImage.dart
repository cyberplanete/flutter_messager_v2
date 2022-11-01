import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final String? initiales;
  final double? radius;

  CustomImage({this.imageUrl, this.initiales, this.radius});

  @override
  Widget build(BuildContext context) {
    // Si l'utilisateur n'a pas d'image de profil, on affiche ses initiales
    if (imageUrl == null || imageUrl!.isEmpty) {
      return CircleAvatar(
        radius: radius ?? 0.0, // si radius est null, alors 0.0
        backgroundColor: Colors.blue,
        child: Text(
          initiales?.toUpperCase() ?? "",
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: radius),
        ),
      );
    } else {
      // Sinon, on affiche l'image de profil
      ImageProvider imageProvider = CachedNetworkImageProvider(imageUrl!); // NetworkImage(imageUrl!);
      // Si radius est null, alors on considère que c'est pour les messages
      if (radius == null) {
        return InkWell(
          // permet de cliquer sur l'image
          child: Image(
            image: imageProvider,
            width: 250,
          ),
          onTap: () {},
        );
      } else {
        // Sinon, on affiche l'image de profil de l'utilisateur dans le profil
        return InkWell(
          // permet de cliquer sur l'image
          child: CircleAvatar(
            radius: radius, // si radius est null, alors 0.0
            backgroundImage: imageProvider,
          ),
          onTap: () {},
        );
      }
    }
  }
}
