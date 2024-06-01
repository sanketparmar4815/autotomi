import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'constant.dart';

class CachedImageContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final String? image;
  final placeholder;
  final double circular;
  final BoxFit? fit;
  final double topCorner;
  final double bottomCorner;
  final flag;

  CachedImageContainer({
    this.height,
    this.width,
    this.image,
    this.circular = 0.0,
    this.placeholder,
    this.fit,
    this.topCorner = 0.0,
    this.bottomCorner = 0.0,
    this.flag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topCorner),
          topRight: Radius.circular(topCorner),
          bottomLeft: Radius.circular(bottomCorner),
          bottomRight: Radius.circular(bottomCorner),
        ),
        child: CachedNetworkImage(
          width: width,
          height: height,
          fit: fit,
          imageUrl: image ?? '',
          placeholder: (context, url) => Container(
            child: image != null
                ? Center(
                    child: SizedBox(
                      child: SpinKitCircle(color: color.appColor, size: 30.0),
                    ),
                  )
                : Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(circular),
                      image: DecorationImage(
                        fit: flag == 1 ? BoxFit.fitHeight : BoxFit.cover,
                        image: AssetImage(placeholder),
                      ),
                    ),
                  ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(circular),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(circular),
              image: DecorationImage(fit: flag == 1 ? BoxFit.fitHeight : BoxFit.cover, image: AssetImage(placeholder)),
            ),
          ),
        ),
      ),
    );
  }
}
