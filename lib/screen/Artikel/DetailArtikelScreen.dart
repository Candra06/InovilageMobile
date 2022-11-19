import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:inovilage/provider/ArtikelProvider.dart';
import 'package:inovilage/static/Utils.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/LoadingWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class DetailArtikelScreen extends StatefulWidget {
  final String id;
  const DetailArtikelScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailArtikelScreen> createState() => _DetailArtikelScreenState();
}

class _DetailArtikelScreenState extends State<DetailArtikelScreen> {
  getDetail() async {
    Provider.of<ArtikelProvider>(
      context,
      listen: false,
    ).getDetailArtikel(widget.id);
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getDetail();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Consumer<ArtikelProvider>(
          builder: (context, data, child) {
            if (data.loading) {
              return const LoadingWidget();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(
                    defaultMargin,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(defaultBorderRadius),
                      bottomRight: Radius.circular(defaultBorderRadius),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: whiteColor,
                        ),
                      ),
                      SizedBox(
                        height: defaultMargin,
                      ),
                      Center(
                        child: TextWidget(
                          label: data.detailArtikel.judul!,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          color: whiteColor,
                          type: 's1',
                          weight: 'bold',
                        ),
                      ),
                      SizedBox(
                        height: defaultMargin,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(defaultMargin),
                    child: SingleChildScrollView(
                      child: Html(
                        data: formatHtmlString(data.detailArtikel.konten!),
                        // style: {
                        //   "body": defaultHtmlStyle.copyWith(
                        //     fontSize: const FontSize(14),
                        //     padding: const EdgeInsets.only(bottom: 16),
                        //   ),
                        //   "li": Style(
                        //     margin: EdgeInsets.zero,
                        //     padding: const EdgeInsets.only(
                        //       top: 2,
                        //     ),
                        //     lineHeight: LineHeight.number(1.1),
                        //   ),
                        // },
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
