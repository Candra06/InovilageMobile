import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/model/AuthModel.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/provider/SampahProvider.dart';
import 'package:inovilage/static/SnackBar.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/ModalOptionWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class ListTrashScreen extends StatefulWidget {
  const ListTrashScreen({Key? key}) : super(key: key);

  @override
  State<ListTrashScreen> createState() => _ListTrashScreenState();
}

class _ListTrashScreenState extends State<ListTrashScreen> {
  AuthModel auth = AuthModel();
  bool loading = false;

  getRole() async {
    var data = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).authData;
    setState(() {
      auth = data!;
    });
  }

  deleteData(String id) async {
    setState(() {
      loading = true;
    });
    Provider.of<SampahProvider>(
      context,
      listen: false,
    ).deleteTrashData(id).then((value) {
      if (value['code'] == '00') {
        Provider.of<SampahProvider>(
          context,
          listen: false,
        ).getListTrash().then((response) {
          if (response['code'] == '00') {
            showSnackBar(
              context,
              '',
              subtitle: value['message'],
              type: 'success',
              duration: 5,
              position: 'Top',
            );
          }
        });
      } else {
        showSnackBar(
          context,
          '',
          subtitle: value['message'],
          type: 'error',
          duration: 5,
          position: 'Top',
        );
      }
    });
    setState(() {
      loading = false;
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getRole();
    });
    super.initState();
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderWidget(
                title: "List Sampah",
              ),
              SizedBox(
                height: defaultMargin,
              ),
              auth.role == 'Admin' ? buttonAdd() : const SizedBox(),
              SizedBox(
                height: defaultMargin,
              ),
              Consumer<SampahProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.listTrash.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Map item = value.listTrash[index].toJson();
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Navigation.formSampahScreen,
                              arguments: {
                                "data": item,
                              });
                        },
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
                              TextWidget(label: "${item['nama']}"),
                              TextWidget(
                                  label: "${item['harga']}/${item['satuan']}"),
                              auth.role == 'Admin'
                                  ? InkWell(
                                      onTap: () {
                                        showConfirmDelete(
                                          item['id'].toString(),
                                        );
                                      },
                                      child: Icon(
                                        Icons.delete_forever,
                                        color: redColor,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              auth.role == 'Admin'
                  ? const SizedBox()
                  : TextWidget(
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

  Widget buttonAdd() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Navigation.formSampahScreen,
          arguments: {
            'data': '',
          },
        );
      },
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              defaultBorderRadius,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.person_add,
              color: whiteColor,
            ),
            const SizedBox(
              width: 4,
            ),
            TextWidget(
              label: "Tambah Data Sampah",
              color: whiteColor,
              weight: 'bold',
            )
          ],
        ),
      ),
    );
  }

  showConfirmDelete(String id) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return ModalOptionWidget(
          contraintHeight: 225,
          title: "Konfirmasi",
          subtitle: 'Apakah anda yakin ingin menghapus data?',
          titleButtonTop: 'Hapus',
          isLoading: loading,
          onPressButtonTop: () => deleteData(id),
          onPressButtonBottom: () => Navigator.pop(context),
          titleButtonBottom: 'Kembali',
          textAlign: TextAlign.start,
          axisText: CrossAxisAlignment.start,
          alignmentText: Alignment.centerLeft,
        );
      },
    );
  }
}
