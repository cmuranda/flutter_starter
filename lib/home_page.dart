import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth/sign_in.dart';
import 'auth/sign_up.dart';
import 'products/product_home_page.dart';

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 60,),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Finance App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                  fontFamily: 'PTSansNarrow',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Image(
              image: AssetImage('assets/images/logo.png'),
              height: 275,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange
              ),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPage())
                );
              },
              child: const Text(
                  "Sign In",
                  style: TextStyle(
                      fontSize: 16
                  )
              ),
            ),
            const SizedBox(height: 20,),
            OutlinedButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage())
                );
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(200, 50),
                  side: const BorderSide(
                      width: 3,
                      color: Colors.orange
                  )
              ),
              child: const Text(
                  "Sign up",
                  style: TextStyle(
                      fontSize: 16
                  )
              ),
            ),
            TextButton(
              onPressed: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ProductsHomePage())
                );
              },
              child: const Text(
                "View as guest",
                style: TextStyle(
                    decoration: TextDecoration.underline
                ),
              ),
            ),
            // TextButton(
            //   onPressed: (){},
            //   child: const Text("View terms and conditions"),
            // )
          ],
        ),
      ),
    );
  }
}
