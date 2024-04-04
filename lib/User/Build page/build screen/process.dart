import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/Text_decorations.dart';

class ProcessDetails extends StatelessWidget {
  const ProcessDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Order Process',style: TextStyling.subtitle3),
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Only for Configurated PC's",style: TextStyling.appTitle),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .5,
                child: Image.asset(
                  'assets/Ads section/process1.jpg',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .5,
                child: Image.asset('assets/Ads section/process2.jpg',filterQuality: FilterQuality.high,fit: BoxFit.fitWidth,),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 8,
                height: MediaQuery.of(context).size.height * .3,
                child: Image.asset(
                  'assets/Ads section/process3.jpg',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fitWidth,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
