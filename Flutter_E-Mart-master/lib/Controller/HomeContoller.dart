
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

@override
void onInit() {
    // TODO: implement onInit
  getUsername();

  super.onInit();
  }

  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }


  var searchController = TextEditingController();

  var username = "";

  getUsername() async {

  var n=  await firestore.collection(usersCollections).where('uid',isEqualTo:currentUser!.uid).get().then((value) {
      if(value.docs.isNotEmpty){
       return value.docs.single['name'];
      }
    });

  username=n;


  }

}