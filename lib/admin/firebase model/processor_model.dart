

import 'package:cloud_firestore/cloud_firestore.dart';

class ProcessorCategoryModel{
  String? categoryId;
  String? series;
  ProcessorCategoryModel({
required this.categoryId,
required this.series,
  });
}

Future submitData(ProcessorCategoryModel data, String idController) async{


}