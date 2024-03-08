import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/Text_decorations.dart';
import 'package:prosample_1/User/utils/colors.dart';

class MotherboardInfo2 extends StatefulWidget {
  final Map<String, dynamic> itemInfo;
  const MotherboardInfo2({super.key, required this.itemInfo});

  @override
  State<MotherboardInfo2> createState() => _MotherboardInfo2State();
}

class _MotherboardInfo2State extends State<MotherboardInfo2> {
  @override
  Widget build(BuildContext context) {
    String imageUrl = widget.itemInfo['image'];
    String categoryName = widget.itemInfo['category'];
    String idNum = widget.itemInfo['idnum'];
    String name = widget.itemInfo['name'];
    String maxClock = widget.itemInfo['maxclock'];
    String model = widget.itemInfo['model'];
    String manufacturer = widget.itemInfo['manufacturer'];
    String processorSocket = widget.itemInfo['processorsocket'];
    String ramType = widget.itemInfo['ramType'];
    String ramSize = widget.itemInfo['ramsize'];
    String ramSlots = widget.itemInfo['ramslots'];
    String ssdType = widget.itemInfo['ssdtype'];
    String ssdSlots = widget.itemInfo['ssdslots'];
    String oldPrice = widget.itemInfo['oldprice'];
    String newPrice = widget.itemInfo['newprice'];
    String dimension = widget.itemInfo['productdimension'];
    String features = widget.itemInfo['features'];
    String voltage = widget.itemInfo['voltage'];
    String formFactor = widget.itemInfo['formfactor'];
    String country = widget.itemInfo['country'];
    String weight = widget.itemInfo['itemweight'];
    String warranty = widget.itemInfo['warranty'];

    // final motherBoard = {
    //   'idnum': idNum,
    //   'category': categoryName,
    //   'image': imageUrl,
    //   'name': name,
    //   'maxclock': maxClock,
    //   'model': model,
    //   'manufacturer': manufacturer,
    //   'processorsocket': processorSocket,
    //   'ramType': ramType,
    //   'ramsize': ramSize,
    //   'ramslots': ramSlots,
    //   'ssdtype': ssdType,
    //   'ssdslots': ssdSlots,
    //   'oldprice': oldPrice,
    //   'newprice': newPrice,
    //   'productdimension': dimension,
    //   'features': features,
    //   'voltage': voltage,
    //   'formfactor': formFactor,
    //   'country': country,
    //   'itemweight': weight,
    //   'warranty': warranty,
    // };
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close, color: AppColors.appTheme),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Product Name', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(name, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('Model Name', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(model, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('Manufacturer', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(manufacturer, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('Processor Socket', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(processorSocket, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('RAM Type', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(ramType, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('RAM Size', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(ramSize, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('RAM Slots', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(ramSlots, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('Storage Type', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(ssdType, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('Storage Slots', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(ssdSlots, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('Product Dimensions', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(dimension, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('Product Features', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(features, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('Voltage', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(voltage, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('Form Factor', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(formFactor, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('Country', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(country, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('Item Weight', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(weight, style: TextStyling.subtitle),
              const SizedBox(height: 10),
              Text('Warranty', style: TextStyling.subtitle2),
              const SizedBox(height: 2),
              Text(warranty, style: TextStyling.subtitle),
              const SizedBox(height: 10),
            ],
          ),
        ),
      )),
    );
  }
}
