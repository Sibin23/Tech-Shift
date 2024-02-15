// import 'package:flutter/material.dart';
// import 'package:prosample_1/admin/utils/colors.dart';
// import 'package:prosample_1/admin/utils/common2.dart';
// import 'package:prosample_1/admin/utils/common_widgets.dart';
// import 'package:prosample_1/admin/utils/text_style.dart';

// class EditProcessor extends StatefulWidget {
//   const EditProcessor({super.key});

//   @override
//   State<EditProcessor> createState() => _EditProcessorState();
// }

// class _EditProcessorState extends State<EditProcessor> {
//   final _formkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: CustomColors.appTheme,
//         title: Text('Update Processor',style: CustomText.apptitle),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child:  Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text('Processor', style: CustomText.title),
//                 const SizedBox(height: 20),
//                 AdminUiHelper.customImageBox(() {
//                   pickImage();
//                 }, imageurl: imageurl),
//                 const SizedBox(height: 20),
//                 Form(
//                     key: _formkey,
//                     child: Column(
//                       children: [
//                         AdminUi.admTextField(
//                             label: 'Product Category',
//                             textcontroller: _productCategory),
//                         const SizedBox(height: 10),
//                         AdminUi.admTextField(
//                             label: 'Product Name',
//                             textcontroller: _productName),
//                         const SizedBox(height: 10),
//                         AdminUi.admTextField(
//                             label: 'Old Price', textcontroller: _oldPrice),
//                         const SizedBox(height: 10),
//                         AdminUi.admTextField(
//                             label: 'New Price', textcontroller: _newPrice),
//                         const SizedBox(height: 10),
//                         Container(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: SizedBox(
//                                 width: MediaQuery.of(context).size.width,
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.36,
//                                 child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text('Series', style: CustomText.title2),
//                                       Card(
//                                         elevation: 0,
//                                           child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text('AMD RYZEN',
//                                                         style: CustomText
//                                                             .categoryText),
//                                                     Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceEvenly,
//                                                         children: [
//                                                           Row(children: <Widget>[
//                                                             Text('5000 Series',
//                                                                 style: CustomText
//                                                                     .categoryTitleText),
//                                                             const SizedBox(
//                                                                 width: 5),
//                                                             Checkbox(
//                                                                 value: amd5,
//                                                                 onChanged:
//                                                                     (bool?
//                                                                         value) {
//                                                                   setState(() {
//                                                                     amd5 =
//                                                                         value!;
//                                                                   });
//                                                                 })
//                                                           ]),
//                                                           const SizedBox(
//                                                               height: 5),
//                                                           Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .spaceEvenly,
//                                                               children: <Widget>[
//                                                                 Text(
//                                                                     '7000 Series',
//                                                                     style: CustomText
//                                                                         .categoryTitleText),
//                                                                 Checkbox(
//                                                                     value: amd7,
//                                                                     onChanged:
//                                                                         (bool?
//                                                                             value) {
//                                                                       setState(
//                                                                           () {
//                                                                         amd7 =
//                                                                             value!;
//                                                                       });
//                                                                     })
//                                                               ])
//                                                         ])
//                                                   ]))),
//                                       Card(
//                                         elevation: 0,
//                                           child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text('Intel',
//                                                         style: CustomText
//                                                             .categoryText),
//                                                     Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Row(children: <Widget>[
//                                                             const SizedBox(
//                                                                 width: 5),
//                                                             Text('12th gen',
//                                                                 style: CustomText
//                                                                     .categoryTitleText),
//                                                             const SizedBox(
//                                                                 width: 5),
//                                                             Checkbox(
//                                                                 value:
//                                                                     intel12th,
//                                                                 onChanged:
//                                                                     (bool?
//                                                                         value) {
//                                                                   setState(() {
//                                                                     intel12th =
//                                                                         value!;
//                                                                   });
//                                                                 })
//                                                           ]),
//                                                           const SizedBox(
//                                                               height: 5),
//                                                           Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .spaceEvenly,
//                                                               children: [
//                                                                 const SizedBox(
//                                                                     width: 5),
//                                                                 Text('13th gen',
//                                                                     style: CustomText
//                                                                         .categoryTitleText),
//                                                                 Checkbox(
//                                                                   value:
//                                                                       intel13th,
//                                                                   onChanged: (value) =>
//                                                                       setState(() =>
//                                                                           intel13th =
//                                                                               value!),
//                                                                 )
//                                                               ])
//                                                         ]),
//                                                     const SizedBox(height: 5),
//                                                     Row(children: <Widget>[
//                                                       const SizedBox(width: 5),
//                                                       Text('14th gen',
//                                                           style: CustomText
//                                                               .categoryTitleText),
//                                                       const SizedBox(width: 5),
//                                                       Checkbox(
//                                                           value: intel14th,
//                                                           onChanged:
//                                                               (bool? value) {
//                                                             setState(() {
//                                                               intel14th =
//                                                                   value!;
//                                                             });
//                                                           })
//                                                     ])
//                                                   ])))
//                                     ]))),
//                         const SizedBox(height: 10),
//                         AdminUi.admTextField(
//                             label: 'Cores', textcontroller: _cores),
//                         const SizedBox(height: 10),
//                         AdminUi.admTextField(
//                             label: 'Threads', textcontroller: _threads),
//                         const SizedBox(height: 10),
//                         AdminUi.admTextField(
//                             label: 'Socket', textcontroller: _socket),
//                         const SizedBox(height: 10),
//                         AdminUi.admTextField(
//                             label: 'Speed', textcontroller: _speed),
//                         const SizedBox(height: 10),
//                         AdminUi.admTextField(
//                             label: 'Cache', textcontroller: _cache),
//                         const SizedBox(height: 10),
//                         AdminUi.admTextField(
//                             label: 'Integrated Graphics',
//                             textcontroller: _integratedGraphics),
//                         const SizedBox(height: 10),
//                         AdminUi.admTextField(
//                             label: 'Included CPU Cooler',
//                             textcontroller: _includedCPUCooler),
//                         const SizedBox(height: 10),
//                         AdminUi.admTextField(
//                             label: 'Unlocked', textcontroller: _unlocked),
//                         const SizedBox(height: 10),
//                         AdminUi.admTextField(
//                             label: 'TDP in (W)', textcontroller: _tdp),
//                         const SizedBox(height: 10),
//                       ],
//                     )),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * .4,
//                   height: MediaQuery.of(context).size.height * .08,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Checkbox(
//                               value: newArival,
//                               onChanged: (bool? value) {
//                                 setState(() {
//                                   newArival = value!;
//                                 });
//                               }),
//                           Text('New Arrival', style: CustomText.title3)
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 AdminUiHelper.customButton(context, () {
//                   if (_formkey.currentState!.validate()) {
//                     submitData();
//                     AdminUiHelper.customSnackbar(context, 'Item Added Successfully !');
//                   }
//                 }, text: 'Save'),
//                 const SizedBox(height: 40)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }