import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

class ImageWidget extends StatelessWidget {
  final String image;
  final double? width, height, widthSvg, heightSvg;
  final EdgeInsets? margin, padding;
  final bool overlayImage;
  final BoxFit fit;
  final Alignment alignment;

  const ImageWidget({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.widthSvg,
    this.heightSvg,
    this.margin,
    this.padding,
    this.overlayImage = false,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = width ?? 0;
    double h = height ?? 0;
    double check = w < h ? w : h;

    return Container(
      margin: margin ?? const EdgeInsets.all(0),
      padding: padding ?? const EdgeInsets.all(0),
      child: Stack(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: image.contains('assets/svg')
                ? SvgPicture.asset(
                    image,
                    width: widthSvg,
                    height: heightSvg,
                    fit: BoxFit.contain,
                    alignment: alignment,
                  )
                : image.indexOf('http') == 0
                    ? CachedNetworkImage(
                        width: width,
                        height: height,
                        imageUrl: image,
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            width: check < 32 ? check : 32,
                            height: check < 32 ? check : 32,
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: fit,
                        alignment: alignment,
                      )
                    : Image.asset(
                        image,
                        width: width,
                        height: height,
                        fit: fit,
                        alignment: alignment,
                      ),
          ),
        ],
      ),
    );
  }
}
