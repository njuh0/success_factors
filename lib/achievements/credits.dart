import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:success_factors/helps/consts.dart';
import 'package:url_launcher/url_launcher.dart';

class Credits extends StatefulWidget {
  const Credits({Key? key}) : super(key: key);

  @override
  _CreditsState createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  Future<void> myLaunchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      showErrorSnackBar();
    }
  }

  void showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Oops... the URL couldn\'t be opened!'),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: bgGradient1,
      ),
      appBar: AppBar(
        title: const Text(
          'CREDITS',
          style:  TextStyle(fontWeight: FontWeight.w900, color: text1),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              genCredit('Bubble','https://rive.app/community/30-41-bubble/','JcToon','https://rive.app/JcToon/','CC BY 4.0','https://creativecommons.org/licenses/by/4.0/',''),
              genCredit('Bubble Demo','https://rive.app/community/629-1225-bubble-demo/','JcToon','https://rive.app/JcToon/','CC BY 4.0','https://creativecommons.org/licenses/by/4.0/',' color changed'),
              genCredit('Space Coffee','https://rive.app/community/194-352-space-coffee/','JcToon','https://rive.app/JcToon/','CC BY 4.0','https://creativecommons.org/licenses/by/4.0/',''),
            ],
          ),
        ),
      )
    );
  }
  Widget genCredit(String title,String tLink, String author, String aLink, String license, String lLink, String description){
    return Wrap(
      children: [
        Text(
          '"',
          style: TextStyle(
              fontSize: size15, color: bg1),
        ),
        InkWell(
          onTap: (){
            myLaunchUrl(tLink);
          },
          child: Text(
            title,
            style: TextStyle(
                fontSize: size15, color: Colors.blue, decoration: TextDecoration.underline),
            ),
        ),
        Text(
          '"',
          style: TextStyle(
              fontSize: size15, color: bg1),
        ),
        Text(
          ' by ',
          style: TextStyle(
              fontSize: size15, color: bg1),
        ),
        InkWell(
          onTap: (){
            myLaunchUrl(aLink);
          },
          child: Text(
            author,
            style: TextStyle(
                fontSize: size15, color: Colors.blue, decoration: TextDecoration.underline),
            ),
        ),
        Text(
          ' is licensed under ',
          style: TextStyle(
              fontSize: size15, color: bg1),
        ),
         InkWell(
          onTap: (){
            myLaunchUrl(lLink);
          },
          child: Text(
            license,
            style: TextStyle(
                fontSize: size15, color: Colors.blue, decoration: TextDecoration.underline),
          ),
        ),
        Text(
          description,
          style: TextStyle(
              fontSize: size15, color: bg1),
        ),
      ],
    );
  }
}