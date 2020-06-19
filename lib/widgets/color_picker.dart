import 'package:flutter/material.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/model/theme_model.dart';
import 'package:mylk/state/global_state.dart';
import 'package:provider/provider.dart';

class ColorPicker extends StatelessWidget {
  final PageController _pageController = PageController(
      viewportFraction: 0.4,
  );

  @override
  Widget build(BuildContext context) {
    final _themeBloc = BlocProvider.of(context).themeBloc;
    final _userBloc = BlocProvider.of(context).userBloc;
    return Consumer<UserState>(
      builder: (context, model, widget) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 50.0),
            color: Colors.white,
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Text("Pick a theme color",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Theme.of(context).primaryColor)),
                Expanded(
                  flex: 1,
                  child: PageView(
                    controller: _pageController,
                    children: themes
                        .map((theme) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  ThemeData newThemeData = ThemeData(
                                      primaryColor:
                                          theme.themeData.primaryColor,
                                      backgroundColor:
                                          theme.themeData.backgroundColor,
                                      fontFamily: 'Quicksand',
                                      textTheme: Theme.of(context).textTheme);
                                  _themeBloc.setTheme(newThemeData);
                                  model.user.themeId = theme.id;
                                  _userBloc.updateUser(model.user);
                                  model.updateUser(model.user);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              theme.themeData.primaryColor,
                                              theme.themeData.backgroundColor
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
