import 'package:flutter/material.dart';
import 'package:inovilage/widget/MenuWidget.dart';
import 'package:inovilage/widget/ModalWidget.dart';

class SelectWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final String title;
  final int selected;
  final Function(int, Map<String, dynamic>) callback;
  const SelectWidget({
    Key? key,
    required this.title,
    required this.data,
    required this.callback,
    required this.selected,
  }) : super(key: key);

  @override
  State<SelectWidget> createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  @override
  Widget build(BuildContext context) {
    return ModalWidget(
      title: widget.title,
      content: Column(
        children: [
          ListView.builder(
            itemCount: widget.data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return MenuWidget(
                title: widget.data[index]['label'],
                useBg: widget.selected == index ? true : false,
                onPress: () {
                  widget.callback(
                    index,
                    widget.data[index],
                  );
                  Navigator.pop(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
