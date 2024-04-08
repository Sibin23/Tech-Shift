import 'package:flutter/material.dart';
import 'package:prosample_1/admin/orders/orders_confirmed.dart';
import 'package:prosample_1/admin/orders/orders_pendings.dart';
import 'package:prosample_1/admin/utils/utils_text_style.dart';


class OrderButtons extends StatelessWidget {
  const OrderButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const OrderPendings())),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(5),boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(1,3)
                    )
                  ]),
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.height * .07,
                  child: Center(child: Text('Pendings',style: CustomText.subtitleWhite)),
                ),
              ),
              GestureDetector(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const OrdersConfirmed())),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.green, boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(1,3)
                    )
                  ], borderRadius: BorderRadius.circular(5)),
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.height * .07,
                  child: Center(child: Text('Confirmed', style: CustomText.subtitleWhite)),
                ),
              ),
            ],
          );
  }
}