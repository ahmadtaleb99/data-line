import 'dart:developer';

import 'package:analyzer/error/error.dart';
import 'package:form_builder_test/data/network/error_handler.dart';


abstract class LocalDataSource  {
  void clearCache();
  void removeFromCache(String key); //if the user logged in as an example and we dont wanna chache his fav


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
      throw CacheException();
    }

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
