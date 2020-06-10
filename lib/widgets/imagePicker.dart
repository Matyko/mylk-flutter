import 'package:flutter/material.dart';

class ImagePicker extends StatefulWidget {
  final Function callback;
  final String selected;

  const ImagePicker({Key key, this.callback, this.selected}) : super(key: key);

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  String _selected;
  List<String> imageNames = [
    "bg-1",
    "bg-2",
    "bg-3",
    "bg-4",
    "bg-5",
    "bg-6",
    "bg-7"
  ];

  @override
  void initState() {
    _selected = widget.selected != null ? widget.selected : imageNames[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List<Widget>();
    imageNames.forEach((name) {
      children.add(FlatButton(
        onPressed: () {
          setState(() {
            _selected = name;
            widget.callback(name);
          });
        },
        child: Container(
          width: 100.0,
          height: 200.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: name == _selected
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              //                   <--- border color
              width: 5.0,
            ),
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/images/$name.jpg"),
                fit: BoxFit.cover),
          ),
        ),
      ));
    });

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Container(
        height: 50.0,
        child: ListView(
          children: children,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
