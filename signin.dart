import '../maintain/imports.dart';






class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
            var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.fromLTRB(h/24,h/10,h/24,h/12),
        child: Stack(
          
          children: [
            //  welcome
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "WEL\nCOME",
                style: TextStyle(fontFamily: 'peb', fontSize: h/15,height: 0.9),
              ),
            ),
            //  welcome
          
          //  cart animation
            Align(
              alignment: Alignment.center,
              child: Lottie.asset(
                'assets/cart.zip',
                height: 150,
                fit: BoxFit.fill,
              ),
            ),
            //  cart animation
          
            Align(
              alignment: Alignment.bottomCenter,
              child:  GoogleButton())
          ],
        ),
      ),
    );
  }
}




class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});
  
  @override
  Widget build(BuildContext context) {
        var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (() {
        a.signInWithGoogle();
      }),
      child: Container(
            decoration: const BoxDecoration(
                color: Color(0xFFB98434),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            height: h / 20,
            width: w / 2.5,
            child: Row(children: [
              Container(
                 height: h / 18,
                 width: w / 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                    color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset("assets/google.png",height: 23,width: 23,),
                ),
              ),
              const Expanded(child: Center(child: Text("SIGN UP    ",style: TextStyle(fontFamily: 'psb',),)))
            ]),
          ),
    );
  }
}




// class T extends StatelessWidget {


//   @override

//   Widget build(BuildContext context) {
 
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(onPressed: (){
//         a.signInWithGoogle();
//         }, child: const Text("Google")),
//       ),
//     );
//   }
// }
