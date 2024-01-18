import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:emart_app/consts/consts.dart';

class Utils{
  //field focus change
  static void fieldFocus(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        margin: EdgeInsets.all(8),
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeOut,
        borderRadius: BorderRadius.circular(8),
        //flushbarPosition: FlushbarPosition.TOP,
        title: message == 'Successful' ? 'Successful' : "Error",
        message: message,
        icon: Icon(
          message == 'Successful' ? Icons.check : Icons.warning,
          size: 28.0,
          color: message == 'Successful' ? Colors.blue[300] : Colors.red[300],
        ),
        leftBarIndicatorColor:
        message == 'Successful' ? Colors.blue[300] : Colors.red[300],

        duration: Duration(seconds: 3),
      )..show(context),
    );
  }

  static void snackbar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        animation: CurvedAnimation(
          parent: AnimationController(
            vsync: context.findAncestorStateOfType<TickerProviderStateMixin>()!,
            duration: Duration(milliseconds: 500),
          ),
          curve: Curves.easeOut,
        ),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        closeIconColor: Colors.white,
        margin: EdgeInsets.all(8),
        clipBehavior: Clip.antiAlias,
        duration: Duration(seconds: 3),
      ),
    );
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: redColor,
      textColor: darkFontGrey,
      fontSize: 16.0,
    );
  }


}