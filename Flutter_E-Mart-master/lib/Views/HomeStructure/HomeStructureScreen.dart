import 'package:emart_app/Controller/HomeContoller.dart';
import 'package:emart_app/Views/AccountScreen/AccountScreen.dart';
import 'package:emart_app/Views/CartScreen/CartScreen.dart';
import 'package:emart_app/Views/CategoryScreen/CategoryScreen.dart';
import 'package:emart_app/Views/HomeScreen/HomeScreen.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    var controller= Get.put(HomeController());

    var naveBarItem =[
      BottomNavigationBarItem(icon: Image.asset( icHome, width: 25),label: home ),
      BottomNavigationBarItem(icon: Image.asset( icCategories, width: 25),label: category ),
      BottomNavigationBarItem(icon: Image.asset( icCart, width: 25),label: cart ),
      BottomNavigationBarItem(icon: Image.asset( icProfile, width: 25),label: account ),
    ];

    var  navBody = [
    const  HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const  AccountScreen(),
    ];

    return  Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(()=>
                navBody.elementAt(controller.currentIndex.value)
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(()=>
         BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
         selectedItemColor: redColor,
          selectedLabelStyle: TextStyle(fontFamily: semibold),
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: naveBarItem,
         onTap: (index){
            controller.changeIndex(index);
          },
         ),
      ),
    );
  }
}
