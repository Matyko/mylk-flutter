import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class MylkImagePicker extends StatefulWidget {
  final Function callback;
  final String selected;

  const MylkImagePicker({Key key, this.callback, this.selected}) : super(key: key);

  @override
  _MylkImagePickerState createState() => _MylkImagePickerState();
}

class _MylkImagePickerState extends State<MylkImagePicker> {
  final picker = ImagePicker();
  String _selected;
  List<String> imagePaths = ["assets/images/bg-1.jpg","assets/images/bg-2.jpg","assets/images/bg-3.jpg","assets/images/bg-4.jpg","assets/images/bg-5.jpg"];

  @override
  void initState() {
    super.initState();
    _selected = widget.selected != null ? widget.selected : imagePaths[0];
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selected = pickedFile.path;
        widget.callback(_selected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List<Widget>();
    imagePaths.forEach((path) {
      children.add(FlatButton(
        onPressed: () {
          setState(() {
            _selected = path;
            widget.callback(path);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: path == _selected
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              width: 3.0,
            ),
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage(path),
                fit: BoxFit.cover),
          ),
        ),
      ));
    });

    children.add(FlatButton(
        onPressed: getImage,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              )),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: FaIcon(FontAwesomeIcons.plusCircle, color: Colors.white),
              )
            ],
          ),
        )));

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Container(
        height: 50.0,
        child: GridView.count(
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.0,
          children: children,
          crossAxisCount: 3,
        ),
      ),
    );
  }
}
