import 'dart:developer';

import 'package:datalines/data/database/hive_database.dart';
import 'package:datalines/data/network/error_handler.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:datalines/domain/model/node/node.dart';
import 'package:datalines/services/io/FileCachingService.dart';
abstract class LocalDataSource  {
  void clearCache();
  void removeFromCache(String key); //if the user logged in as an example and we dont wanna cache his fav

  void saveSubmission(Submission submission);
  Future<void>  addSubmission(Submission submission);
  List<FormModel>? getAssignedForms();
  List<FormModel>? getInactiveForms();
  FormModel? getForm(String formId);
  Future<void> saveFormsToDataBase(List<FormModel> assignedForms);
  List<Submission> getSubmissions(String formId);
  Future<void> deleteSubmission(Submission submission);
  Future<void> deleteSubmissionsRange(String formId, int startIndex,int endIndex);
  Future<void> updateSubmission (Submission submission) ;
  List<Node>? getNodes();
  Future<void> saveNodes(List<Node> nodes);
  Future<void> saveInactiveForms(List<FormModel> forms);
  Future<void> saveInactiveForm(FormModel form);
  Future<void> deleteInactiveForm(String formId);
  Future<void> deleteForm(FormModel form);
  bool formHasSubmissions(String formId);

  // Future<String> saveFileToCache(String path,int SubmissionId,String formName);
  // Future<void> deleteFileFromCache(String path);

 //  HomeResponse getHomeData();
 // void saveHomeToCache(HomeResponse homeResponse);
 //
 //  StoreDetailsResponse getStoreDetails(int id );
 //  void saveStoreDetailsToCache(StoreDetailsResponse storeDetailsResponse);


}


const String keyHomeCache = 'keyHomeCache';
const int keyHomeCacheTime = 60;

const String keyStoreDetails = 'keyStoreDetails';
const int keyStoreDetailsCacheTime = 60;

class LocalDataSourceImpl implements LocalDataSource {

  final HiveDatabase _hiveDatabase;
  final FileCachingService _ioService;

  LocalDataSourceImpl(this._hiveDatabase, this._ioService);

  Map <String,CachedItem> _cacheMap  = {};


  @override
  void clearCache() => _cacheMap.clear();

  @override
  void removeFromCache(String key) => _cacheMap.remove(key);



  dynamic _getFromCache(String key){
    CachedItem? cachedItem = _cacheMap[key] ;

    if(cachedItem != null && cachedItem.isValidCache ) {
      return cachedItem.data;
    }
    else {
      throw CacheException('cache is expired');
    }

  }

  @override
  List<FormModel>? getAssignedForms() {
    return _hiveDatabase.getAssignedForms();

  }

  @override
  List<Submission> getSubmissions(String formId) {
    return _hiveDatabase.getAllSubmissions(formId) ?? [ ];

  }

  @override
  Future<void> saveFormsToDataBase(List<FormModel> assignedForms) async {
    log('here');
    await _hiveDatabase.saveAssignedForms(assignedForms);
  }

  @override
  Future<void> addSubmission(Submission submission) async {

    await   _hiveDatabase.addSubmission(submission);
  }

  @override
  void saveSubmission(Submission submission) {
  }

  @override
  Future<void> deleteSubmission(Submission submission) async {
  await  _hiveDatabase.deleteSubmission(submission);
  }

  @override
  Future<void> updateSubmission (Submission submission) async {
    await   _hiveDatabase.updateSubmission(submission);
  }

  @override
  List<Node>? getNodes() {
    return   _hiveDatabase.getNodes();

  }

  @override
  Future<void> saveNodes(List<Node> nodes) async{
    return  _hiveDatabase.saveNodes(nodes);
  }

  @override
  bool formHasSubmissions(String formName) {
     return _hiveDatabase.formHasSubmissions(formName);
  }

  @override
  Future<void> saveInactiveForms(List<FormModel> forms) async {
    await _hiveDatabase.addInactiveForms(forms);
    }

  @override
  List<FormModel>? getInactiveForms() {
    return _hiveDatabase.getInactiveForms();
  }

  @override
  Future<void> deleteSubmissionsRange(String formId, int startIndex, int endIndex) async{
    await _hiveDatabase.deleteSubmissionsRage(formId, startIndex, endIndex);
  }

  @override
  FormModel? getForm(String formId) {
   return _hiveDatabase.getForm(formId);
  }

  @override
  Future<void> saveInactiveForm(FormModel form) async{
    await _hiveDatabase.saveInactiveForm(form);
  }

  @override
  Future<void> deleteInactiveForm(String formId) async{
    await _hiveDatabase.deleteInactiveForm(formId);
  }

  @override
  Future<void> deleteForm(FormModel form) async {
    await _hiveDatabase.deleteForm(form);
  }





}

class CachedItem {
  dynamic data;

  final  int _timeWhenCached = DateTime.now().millisecondsSinceEpoch;
  final int cacheTimeInSeconds;
  bool get isValidCache {
    var timeNow = DateTime.now().millisecondsSinceEpoch;

    if(timeNow  < _timeWhenCached +  (cacheTimeInSeconds * 1000) ){
      return true;
    }
    return false;
  }

  CachedItem(this.data, {required this.cacheTimeInSeconds});
}

// 1000 seconds when cached
// 60 cache time
//time now 1061
// class SubmissionsException {
//   final String message;
//   SubmissionsException(this.message)
// }
