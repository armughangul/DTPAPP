import 'package:cached_network_image/cached_network_image.dart';
import 'package:decisive_technology_products/utils/full_photo.dart';
import 'package:decisive_technology_products/utils/utils.dart';
import 'package:flutter/material.dart';
import '../s.dart';
import 'loading.dart';

// ignore: must_be_immutable
class GetImage extends StatelessWidget {
  String? imagePath;
  final double width;
  final double height;
  final BoxFit fit;
  final double radius;
  bool isAssets;
  final Color? imageColor;
  final VoidCallback? onTap;
  BorderRadius? borderRadius;
  GetImage(
      {this.imagePath,
      this.width = Siz.leadingImageSize,
      this.height = Siz.leadingImageSize,
      this.fit = BoxFit.cover,
      this.radius = Siz.fieldRadius,
      this.isAssets = false,
      this.imageColor,
      this.onTap,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    if (borderRadius == null) {
      borderRadius = BorderRadius.circular(radius);
    }
    if (imagePath == null || imagePath!.isEmpty) {
      imagePath =
          'https://i.picsum.photos/id/866/200/200.jpg?hmac=i0ngmQOk9dRZEzhEosP31m_vQnKBQ9C19TBP1CGoIUA';
    }
    return InkWell(
      onTap: onTap ?? () => S.sSetRout(context, page: FullPhoto(imagePath!)),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: isAssets
            ? Container(
                height: height,
                width: width,
                child: Image.asset(
                  imagePath!,
                  color: imageColor,
                  width: width,
                  height: height,
                  fit: fit,
                ),
              )
            : CachedNetworkImage(
                imageUrl: imagePath!,
                imageBuilder: (context, imageProvider) => Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: fit,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  height: height,
                  width: width,
                  decoration: S.sBoxDecorationWithoutShadow(
                    radius: Siz.imageRadius,
                  ),
                  child: LoadingPro(),
                ),
                errorWidget: (context, url, error) => Container(
                  height: height,
                  width: width,
                  decoration: S.sBoxDecorationWithoutShadow(
                    radius: Siz.imageRadius,
                  ),
                  child: Image.network(imagePath!),
                ),
              ),
      ),
    );
  }
}
