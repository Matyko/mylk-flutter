import 'package:flutter/material.dart';
import 'package:mylk/bloc/bloc_provider.dart';
import 'package:mylk/model/theme_model.dart';
import 'package:mylk/model/user_model.dart';
import 'package:mylk/state/global_state.dart';
import 'package:provider/provider.dart';

class ColorPicker extends StatelessWidget {
  final PageController _pageController = PageController(
      viewportFraction: 0.6
  );

  @override
  Widget build(BuildContext context) {
    final _themeBloc = BlocProvider.of(context).themeBloc;
    final _userBloc = BlocProvider.of(context).userBloc;
    return Consumer<UserState>(
      builder: (context, model, widget) => Container(
        color: Colors.white,
        constraints: BoxConstraints(
          maxHeight: 200.0
        ),
        child: Column(
          children: <Widget>[
            Text("Pick a theme color"),
            Expanded(
              flex: 1,
              child: PageView(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                children: themes.map((theme) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      ThemeData newThemeData = ThemeData(
                          primaryColor: theme.themeData.primaryColor,
                          backgroundColor: theme.themeData.backgroundColor,
                          fontFamily: 'Quicksand',
                          textTheme: Theme.of(context).textTheme
                      );
                      _themeBloc.setTheme(newThemeData);
                      model.user.themeId = theme.id;
                      _userBloc.updateUser(model.user);
                      model.updateUser(model.user);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [theme.themeData.primaryColor, theme.themeData.backgroundColor],
                        ),
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                    ),
                  ),
                )).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
