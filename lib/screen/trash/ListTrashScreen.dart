import 'package:flutter/material.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/TextWidget.dart';

class ListTrashScreen extends StatefulWidget {
  const ListTrashScreen({Key? key}) : super(key: key);

  @override
  State<ListTrashScreen> createState() => _ListTrashScreenState();
}

class _ListTrashScreenState extends State<ListTrashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          defaultMargin,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const HeaderWidget(
                title: "List Sampah",
              ),
              SizedBox(
                height: defaultMargin,
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            defaultBorderRadius,
                          ),
                        ),
                        border: Border.all(
                          color: primaryColor,
                        ),
                        color: whiteColor,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: defaultMargin,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(label: "Botol"),
                          TextWidget(label: "400/kg"),
                        ],
                      ),
                    ),
                  );
                },
              ),
              TextWidget(
                label: "Harga bisa berubah sewaktu-waktu !",
                type: 'b1',
                color: primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
