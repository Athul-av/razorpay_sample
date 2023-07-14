import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

   List<String> images = [
    'assets/sss.jpeg','assets/sss2.jpg','assets/sss3.jpg','assets/sss4.jpg','assets/sss5.jpg','assets/sss6.jpg'
   ];

   Razorpay razorpay = Razorpay(); 

  @override
  void initState() {
    super.initState();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_NNbwJ9tmM0fbxj',
      'amount': 28200,
      'name': 'Athul',
      'description': 'Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse? response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: ${response?.paymentId}", );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: ${response.code} - ${response.message}",
         );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName}",);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.white,
        title:const Text('RazorPay',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
       ),

       body: SafeArea(child: Padding(
         padding: const EdgeInsets.only(top: 10),
         child: GridView.builder(
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 250),
          itemCount: 6, 
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(05.0),
              child: Container(
                
                decoration:const BoxDecoration(
                   color: Color.fromARGB(255, 245, 245, 245),  
                   borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                       decoration: BoxDecoration(
                   image: DecorationImage(image: AssetImage(images[index]),fit: BoxFit.cover), 
                   borderRadius:const BorderRadius.all(Radius.circular(10))
                ),
                        width: double.infinity,
                        height: 170,  
                      ),
                    ),
                   Padding(
                     padding:const  EdgeInsets.only(left: 12,right: 10),
                     child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [
                       const Text('₹9999',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                        TextButton(onPressed: (){
                          openCheckout(); 
                        }, child:const Text("Buy"))
                      ],),
                   )
                  ],
                ),
              ),
            );
          },
         ),
       )),
    );
  }
} 