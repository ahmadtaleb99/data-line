import 'dart:developer';
import 'dart:convert';

import 'dart:io';


   String json  = '[{"id":1,"name_en":"الكترونيات","name_pt":"الكترونيات","name_ar":"الكترونيات","status":1,"parent_id":null,"created_at":"2022-06-22T07:38:19.000000Z","updated_at":"2022-06-22T08:42:04.000000Z","all_active_children":[{"id":2,"name_en":"موبايلات","name_pt":"موبايلات","name_ar":"موبايلات","status":1,"parent_id":1,"created_at":"2022-06-22T07:38:31.000000Z","updated_at":"2022-06-23T06:32:51.000000Z","all_active_children":[]},{"id":3,"name_en":"لابتوبات","name_pt":"لابتوبات","name_ar":"لابتوبات","status":1,"parent_id":1,"created_at":"2022-06-22T07:38:43.000000Z","updated_at":"2022-06-23T06:32:49.000000Z","all_active_children":[]}]},{"id":4,"name_en":"طعام","name_pt":"طعام","name_ar":"طعام","status":1,"parent_id":null,"created_at":"2022-06-22T07:38:56.000000Z","updated_at":"2022-06-23T07:00:25.000000Z","all_active_children":[{"id":5,"name_en":"فواكه","name_pt":"فواكه","name_ar":"فواكه","status":1,"parent_id":4,"created_at":"2022-06-22T07:39:09.000000Z","updated_at":"2022-06-23T07:00:01.000000Z","all_active_children":[{"id":6,"name_en":"موز","name_pt":"موز","name_ar":"موز","status":1,"parent_id":5,"created_at":"2022-06-22T07:39:23.000000Z","updated_at":"2022-06-23T06:25:23.000000Z","all_active_children":[]}]}]}]';
Future<void> main() async {

  var decodedJson = jsonDecode(json);

  makeTreeFlat(decodedJson);

  var file = File('1.txt');
  file.writeAsString(array.toString());
  Map map ={};
}

var array = [];


void makeTreeFlat(dynamic category){


  for(var subCatgory in category){


    if(subCatgory['all_active_children'] != null)
    array.add(subCatgory.remove('all_active_children'));


      if(subCatgory['all_active_children'] != null)
      makeTreeFlat(subCatgory['all_active_children']);
  }


}