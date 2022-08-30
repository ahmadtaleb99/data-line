import 'dart:developer';
import 'dart:io';

import 'package:analyzer/error/error.dart';
import 'package:form_builder_test/data/database/hive_database.dart';
import 'package:form_builder_test/data/network/error_handler.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/services/io/FileCachingService.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
abstract class LocalDataSource  {
  void clearCache();
  void removeFromCache(String key); //if the user logged in as an example and we dont wanna cache his fav

  void saveSubmission(Submission submission);
  Future<void>  addSubmission(Submission submission);
  AssignedForms getAssignedForms();
  Future<void> saveFormsToDataBase(AssignedForms assignedForms);
  List<Submission> getSubmissions(String formName);
  Future<void> deleteSubmission(Submission submission);
  Future<void> updateSubmission (Submission submission) ;
  Future<String> saveFileToCache(String path,int SubmissionId,String formName);
  Future<void> deleteFileFromCache(String path);

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
  AssignedForms getAssignedForms() {
    return _hiveDatabase.getAssignedForms();

  }

  @override
  List<Submission> getSubmissions(String formName) {
    return _hiveDatabase.getAllSubmissions(formName) ?? [ ];

  }

  @override
  Future<void> saveFormsToDataBase(AssignedForms assignedForms) async {
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
  Future<void> deleteFileFromCache(String path) {
    // TODO: implement deleteFileFromCache
    throw UnimplementedError();
  }

  @override
  Future<String> saveFileToCache(String path,int SubmissionId,String formName) async {
   return await _ioService.cacheFile(File(''), 'SubmissionId, formName');
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
