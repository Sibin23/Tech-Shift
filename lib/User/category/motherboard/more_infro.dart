import 'package:flutter/material.dart';
import 'package:prosample_1/User/utils/Text_decorations.dart';

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
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Text('Product Name'),
          const SizedBox(height: 5),
          Text(name, style: TextStyling.subtitle),
          const SizedBox(height: 10),
          Text('Model Name'),
          const SizedBox(height: 5),
          Text(model, style: TextStyling.subtitle2),
          Text('Manufacturer'),
          Text(manufacturer, style: TextStyling.subtitle2),
          Text('Processor Socket'),
          Text(processorSocket, style: TextStyling.subtitle2),
        ],
      )),
    );
  }
}
