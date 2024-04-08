import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/utils_text_decorations.dart';

class WarrantyPolicy extends StatelessWidget {
  const WarrantyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 10);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Warranty policy', style: TextStyling.appTitle),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Text('1.', style: TextStyling.subtitle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'All products sold by us carry only carry-in warranty. Shipping charges (To & Fro) to service center has to be born by the customer.',
                        style: TextStyling.subtitle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            space,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Text(
                        '2.',
                        style: TextStyling.subtitle,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          'Where the words “Direct Warranty” or “Manufacturer Warranty” are mentioned it means warranty is direct by Manufacturer / Distributor.',
                          style: TextStyling.subtitle),
                    ),
                  ),
                ],
              ),
            ),
            space,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Text('3.', style: TextStyling.subtitle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          'We request the customer to send the copy of our invoice and delivery challan for warranty purposes always when there is a service problem for products. Shipping will be paid by the customer for the same. Goods once sold will be accepted for warranty repair / replacement only if they are in good physical condition. Products with broken / burnt pins, pen / pencil markings, cracks, missing / tampered components / warranty stickers damaged will be rejected and considered warranty void in above conditions.',
                          style: TextStyling.subtitle),
                    ),
                  ),
                ],
              ),
            ),
            space,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Text('4.', style: TextStyling.subtitle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          'Warranty clause stand void for damage caused due to mishandling of equipments for any reasons causing damage of the products like lack of knowledge, improper handling, electricity problem etc., on the basis that under normal condition there would have been no damage of the product.',
                          style: TextStyling.subtitle),
                    ),
                  ),
                ],
              ),
            ),
            space,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Text('5.', style: TextStyling.subtitle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          'Warranty is against manufacturing defects only, and as per manufacturers warranty policy. In case manufacturer has local service centre then for warranty the customer has to approach the service center directly with the purchase details.',
                          style: TextStyling.subtitle),
                    ),
                  ),
                ],
              ),
            ),
            space,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Text('6.', style: TextStyling.subtitle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          'Products under warranty will either be repaired or replaced as per manufacturer/ supplier warranty policy.',
                          style: TextStyling.subtitle),
                    ),
                  ),
                ],
              ),
            ),
            space,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Text('7.', style: TextStyling.subtitle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          "We reserve the right to reject material received for warranty without accessories, manuals, Software CD’s / DVD’s & outer box packing.",
                          style: TextStyling.subtitle),
                    ),
                  ),
                ],
              ),
            ),
            space,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Text('8.', style: TextStyling.subtitle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          'Any service litigations or problems have to address directly to manufacturers/distributor/company direct dealer address only. We are not responsible for any litigation thereof.',
                          style: TextStyling.subtitle),
                    ),
                  ),
                ],
              ),
            ),
            space,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Text('9.', style: TextStyling.subtitle)),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          'Warranty service will be given only where the full payment is made on the date of purchase itself.',
                          style: TextStyling.subtitle),
                    ),
                  ),
                ],
              ),
            ),
            space,
          ],
        ),
      ),
    )));
  }
}
