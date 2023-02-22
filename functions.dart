import 'dart:io';

import 'package:cart/screens/pages/search.dart';

import '../screens/Auth/details.dart';
import '../screens/maintain/imports.dart';

class Cart extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  //   zero();
  // }

  var cart = {}.obs;

  var full = 0.obs;
  var path = "".obs;
  get k => cart.keys.toList();
  get v => cart.values.toList();
  var url = ''.obs;

//  to upload pic
  void pick() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      path.value = picked.path;

      final FirebaseAuth auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      final userid = user?.uid;

      UploadTask uploadTask = FirebaseStorage.instance
          .ref("logo")
          .child(userid.toString())
          .putFile(File(path.value));

      TaskSnapshot snapshot = await uploadTask;

      String? imageUrl = await snapshot.ref.getDownloadURL();
      url.value = imageUrl;
    } else {
      Get.snackbar("NO Image Selectd", " no");
    }
  }

  details(var name, var gst, var upi, var address, var number) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final userid = user?.uid;
    var db = FirebaseFirestore.instance;
    var pointer = db.collection("users").doc(userid);

    await pointer.set({
      "name": name,
      "gst": gst,
      "address": address,
      "upi": upi,
      "number": number,
      "url": url.value.toString()
    });
  }

// update details
  updateDetails(
      var name, var gst, var upi, var address, var number, var url) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final userid = user?.uid;
    var db = FirebaseFirestore.instance;
    db.collection("users").doc(userid).update({
      "name": name,
      "gst": gst,
      "address": address,
      "upi": upi,
      "number": number,
      "url": url
    });
  }

  updatekey(var key, var value) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final userid = user?.uid;
    var db = FirebaseFirestore.instance;
    db.collection("users").doc(userid).update({
      "$key": value,
    });
  }

// to decrese stock
  change() async {
    for (var p in k) {
      var val = cart[p];
      QuerySnapshot querySnap = await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid.toString())
          .where('name', isEqualTo: p.toString())
          .get();
      QueryDocumentSnapshot doc = querySnap.docs[
          0]; // Assumption: the query returns only one document, THE doc you are looking for.
      DocumentReference docRef = doc.reference;
      await docRef.update({"stock": FieldValue.increment(-val)});
    }
  }

//  to make pdf
  make({required String name, required int number}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final userid = user?.uid;

    DateTime date = DateTime.now();
    var formattedDate = "${date.day}-${date.month}-${date.year}";

    DocumentSnapshot response =
        await FirebaseFirestore.instance.collection("users").doc(userid).get();
    return topdf(
        name: response['name'],
        gst: response['gst'],
        url: response['url'],
        cnumber: name,
        customer: number,
        compnayNumber: response['number'],
        compnayAddress: response['address'],
        compnayUpi: response['upi'],
        date: formattedDate);
  }

  addProduct(Product product) {
    if (cart.containsKey(product)) {
      return null;
    } else {
      cart[product] = 1;
    }
  }

  increment(Product product) {
    if (cart.containsKey(product)) {
      cart[product] += 1;
    } else {
      cart[product] = 1;
    }
    Get.snackbar("Product ", "Alredy Added",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
  }

  void removeproduct(Product product) {
    if (cart.containsKey(product) && cart[product] == 1) {
      cart.removeWhere((key, value) => key == product);
    } else {
      cart[product] -= 1;
    }
  }

  minus(Product product) {
    if (cart.containsKey(product)) {
      if (cart[product] >= 1) {
        cart[product] -= 1;
      } else if (cart[product] < 0) {
        cart.remove(product);
        Get.to(() => P());
        Get.snackbar("Product ", "Removed",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 1));
      }
    } else {
      cart[product] = 0;
    }
  }

  zero() {
    // cart.clear();
    full.value = 0;
  }

  total() {
    if (cart.isNotEmpty) {
      full.value = cart.entries
          .map((e) => e.key.cost * e.value)
          .toList()
          .reduce((value, element) => value + element);
    } else {
      return null;
    }
  }

  // discount() {
  //   if (cart.isNotEmpty) {
  //     return full.value - int.parse(less.text);
  //   } else {
  //     null;
  //   }
  // }

  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      Get.dialog(Center(
        child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            alignment: Alignment.center,
            child: CircularProgressIndicator()),
      ));
      final GoogleSignInAccount? account = await GoogleSignIn().signIn();
      Get.back();
      if (account != null) {
        Get.dialog(Center(
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            alignment: Alignment.center,
            child: Lottie.asset(
              'assets/loading.zip',
              height: 125,
              //  fit: BoxFit.fill,
            ),
          ),
        ));
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await account.authentication;
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        UserCredential usercred =
            await FirebaseAuth.instance.signInWithCredential(credential);
        // Once signed in, return the UserCredential
        Get.back();

        ///Her to check isNewUser OR Not
        if (usercred.additionalUserInfo!.isNewUser) {
          if (usercred.user != null) {
            Get.to(() => D());
          }
        } else {
          Get.to(() => MyApp());
        }

        return usercred.user;
      }
    } on FirebaseAuthException catch (e) {
      var content = '';
      switch (e.code) {
        case 'account-exists-with-different-credential':
          content = "This account exists with different sign in credentials";
          break;

        case 'invalid-credential':
          content = "This account exists with different sign in credentials";
          break;

        case 'operation-not-allowed':
          content = "This account exists with different sign in credentials";
          break;

        case 'user-disabled':
          content = "This account exists with different sign in credentials";
          break;

        case 'user-not-found':
          content = "This account exists with different sign in credentials";
          break;
      }
      Get.dialog(Center(
        child: Text(content),
      ));
    } catch (e) {
      Get.dialog(Center(
        child: Text(e.toString()),
      ));
    }
    return null;
  }

  Future push(String product, int cost, int stock) async {
    var db = FirebaseFirestore.instance;
    var users =
        db.collection(FirebaseAuth.instance.currentUser!.uid.toString());
    await users.add(
        Product(name: product, cost: cost, stock: stock, category: "Legend")
            .toMap());
  }

  Future bill(String name, int amount, int number) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final userid = user?.uid;
    var db = FirebaseFirestore.instance;
    var users = db.collection("bills").doc(userid).collection("invoices");
    DateTime date = DateTime.now();
    var formattedDate = "${date.day}-${date.month}-${date.year}";
    await users.add({
      "customer": name,
      "amount": amount,
      "phone": number,
      "date": formattedDate
    });
  }

  Future userid() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final userid = user?.uid;
    return userid;
  }

  getcategory() async {
    Set set = {};

    QuerySnapshot x =
        await FirebaseFirestore.instance.collection('products').get();

    for (var element in x.docs) {
      set.add(element["category"]);
      //  final categories = list.map((e) => e.category).toSet();
    }
    print(set.toString());
    return set;
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
