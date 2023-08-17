import 'package:flutter/material.dart';
import 'package:piyon_planner_update/functions/hexColor.dart';
import 'package:piyon_planner_update/pages/appbar.dart';
import 'package:piyon_planner_update/pages/menu.dart';
import 'package:provider/provider.dart';

class PageModel with ChangeNotifier {  // We define our Provider class
  int _page_number = 0; // We enter the index number of the list that we want to be displayed.

  int get page => _page_number; // We define getter method to access page variable

  List<String> pages = [
    'lib/files/page1',
    'lib/files/page2',
    'lib/files/page3',
    'lib/files/page4',
    'lib/files/page5',
    'lib/files/page6',
    'lib/files/page7',
    'lib/files/page8',
    'lib/files/page9',
    'lib/files/page10',
    'lib/files/page11',
    'lib/files/page12',
    'lib/files/page13',
    'lib/files/page14',
    'lib/files/page15',
  ]; // We include the images we want to be shown in the list

  void nextPage() { // We define a function to increase the index number
    _page_number++;
    notifyListeners();
  }
}

class PromotionalPagesRemote extends StatelessWidget { // Basic configuration and provider definition
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PageModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Piyon Planner',
        home: PromotionalPages(),
      ),
    );
  }
}

class PromotionalPages extends StatelessWidget {  // Class to create the interface
  @override
  Widget build(BuildContext context) {
    final pageModel = Provider.of<PageModel>(context);
    final sizes = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: HexColor("#0F0F0F"),
        body: buton_check(pageModel._page_number, sizes, pageModel, context));
  }
}

Widget buton_check(int value, sizes, pageModel, context) { //We define a function that returns different widget trees depending on the situation that checks whether we are in the final image.
  if (value == 14) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushAndRemoveUntil( // After the last image, we are redirecting to the main menu.
            context,
            MaterialPageRoute(builder: (context) => MenuRemote()),
            (route) => false,
          );
        },
        child: Container(
          child: AnimatedSwitcher( // We define the animation that we activate via gesture detector
            duration: Duration(seconds: 1), // Image is set to disappear after 1 second
            transitionBuilder: (Widget child, Animation<double> animation) { // transitionBuilder is defined, which allows us to create animations
              return FadeTransition( // Fade animation is defined
                opacity: animation,
                child: child,
              );
            },
            child: Image.asset( // Image is taken from the model
              '${pageModel.pages[pageModel._page_number]}',
              key: ValueKey(pageModel._page_number),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  } else {
    return Center(
        child: GestureDetector(
      child: Container(
        child: AnimatedSwitcher(
          duration: Duration(seconds: 1),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: Image.asset(
            '${pageModel.pages[pageModel._page_number]}',
            key: ValueKey(pageModel._page_number),
            fit: BoxFit.fill,
          ),
        ),
      ),
      onTap: () {
        pageModel.nextPage(); // The index number is incremented by 1 to move to the next page.
      },
    ));
  }
}
