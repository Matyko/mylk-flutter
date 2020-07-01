import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MylkBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function callback;

  const MylkBottomNavigationBar(this.selectedIndex, this.callback);

  @override
  _MylkBottomNavigationBarState createState() =>
      _MylkBottomNavigationBarState();
}

class _MylkBottomNavigationBarState extends State<MylkBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 15.0,
      child: Container(
        height: 50.0,
        child: Stack(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    onPressed: () {
                      widget.callback(0);
                    },
                    child: FaIcon(FontAwesomeIcons.home,
                        color: widget.selectedIndex == 0
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).backgroundColor),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    onPressed: () {
                      widget.callback(1);
                    },
                    child: FaIcon(FontAwesomeIcons.solidCheckSquare,
                        color: widget.selectedIndex == 1
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).backgroundColor),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    onPressed: () {
                      widget.callback(2);
                    },
                    child: FaIcon(FontAwesomeIcons.bookOpen,
                        color: widget.selectedIndex == 2
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).backgroundColor),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    onPressed: () {
                      widget.callback(3);
                    },
                    child: FaIcon(FontAwesomeIcons.chartPie,
                        color: widget.selectedIndex == 3
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).backgroundColor),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container()
                )
              ],
            ),
            AnimatedPositioned(
              top: 0.0,
              left: MediaQuery.of(context).size.width / 5 * widget.selectedIndex,
              width: MediaQuery.of(context).size.width / 5,
              height: 2.5,
              duration: Duration(milliseconds: 250),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
