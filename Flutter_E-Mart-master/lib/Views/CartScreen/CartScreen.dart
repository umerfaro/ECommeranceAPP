
import 'package:emart_app/consts/consts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CartScreen> {



  @override
  Widget build(BuildContext context) {
    return  Container(
      color: lightGrey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 100.0,
              backgroundImage:
              AssetImage(emptyCart),
            ),
            20.heightBox,
            cartEmpty.text.size(20).fontFamily(semibold).color(darkFontGrey).make(),
           20.heightBox,
            cartEmptyMsg.text.size(14).fontFamily(semibold).align(TextAlign.center).color(darkFontGrey).make(),


          ]
      ),


    );
  }
}
