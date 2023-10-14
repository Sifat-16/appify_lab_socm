// /*
// import 'package:aircraft_inventory_management/models/category.dart';
// import 'package:aircraft_inventory_management/models/stock_history.dart';
// import 'package:aircraft_inventory_management/models/stock_record.dart';
// import 'package:aircraft_inventory_management/res/constants.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
//
// class HiveManager{
//   HiveConstants hiveConstants = sl.get<HiveConstants>();
//
//   Future<void> setupHive()async{
//     var directory = await getApplicationDocumentsDirectory();
//     //Hive.init(directory.path);
//     await Hive.initFlutter("${directory.path}/tetranos_db");
//
//     Hive.registerAdapter(UserAdapter());
//     Hive.registerAdapter(CategoryAdapter());
//     Hive.registerAdapter(StockHistoryAdapter());
//     Hive.registerAdapter(StockRecordAdapter());
//     await Hive.openBox<User>(hiveConstants.userClassBoxName);
//     await Hive.openBox<Category>(hiveConstants.aircraftBoxName);
//     await Hive.openBox<StockRecord>(hiveConstants.stockRecordBoxName);
//     await Hive.openBox<StockHistory>(hiveConstants.stockHistoryBoxName);
//     await Hive.openBox<List<StockHistory>>(hiveConstants.stockListHistoryBox);
//
//     print('hive setup finished');
//   }
//
//
//   Future<Box<String>> getSampleBox()async{
//     if(!Hive.isBoxOpen('sample')){
//       await Hive.openBox<String>('sample');
//     }
//     return Hive.box<String>('sample');
//   }
//
//   Future<void> addSampleData(String user)async{
//     var userBox = await getSampleBox();
//     try{
//       await userBox.put(hiveConstants.myProfileKey, user);
//       print('user String data is inserted');
//     }catch(e){
//       print('user String data input exception');
//       print(e);
//     }
//   }
//
//   Future<String?> getSampleData()async{
//     var userBox = await getSampleBox();
//     return userBox.get(hiveConstants.myProfileKey);
//   }
//
//
//   Future<Box<User>> getUserBox()async{
//     if(!Hive.isBoxOpen(hiveConstants.userClassBoxName)){
//       await Hive.openBox<User>(hiveConstants.userClassBoxName);
//     }
//     return Hive.box<User>(hiveConstants.userClassBoxName);
//   }
//   Future<Box<StockRecord>> getStockRecordBox()async{
//     if(!Hive.isBoxOpen(hiveConstants.stockRecordBoxName)){
//       await Hive.openBox<StockRecord>(hiveConstants.stockRecordBoxName);
//     }
//     return Hive.box<StockRecord>(hiveConstants.stockRecordBoxName);
//   }
//   Box<StockHistory> getStockHistoryBox(){
//     return Hive.box<StockHistory>(hiveConstants.stockHistoryBoxName);
//   }
//
//   Box<List<StockHistory>>getStockListHistoryBox(){
//     */
// /*if(!Hive.isBoxOpen(hiveConstants.stockListHistoryBox)){
//       await Hive.openBox<List<StockHistory>>(hiveConstants.stockListHistoryBox);
//     }*//*
//
//     return Hive.box<List<StockHistory>>(hiveConstants.stockListHistoryBox);
//   }
//
//
//   //User operation
//
//   Future<void> addUserData(User user)async{
//     var userBox = await getUserBox();
//     try{
//       await userBox.put(hiveConstants.myProfileKey, user);
//       print('user data is inserted');
//     }catch(e){
//       print('user data input exception');
//       print(e);
//     }
//   }
//
//   Future<void> deleteUserData()async{
//     var userBox = await getUserBox();
//     try{
//       await userBox.delete(hiveConstants.myProfileKey);
//       print('user data is inserted');
//     }catch(e){
//       print('user data input exception');
//       print(e);
//     }
//   }
//
//   Future<User?> getUserData()async{
//     var userBox = await getUserBox();
//     return userBox.get(hiveConstants.myProfileKey);
//   }
//
//
//   //StockRecord operation
//
//   Future<void> addStockRecordData(StockRecord stockRecord)async{
//     var stockRecordBox = await getStockRecordBox();
//     try{
//       await stockRecordBox.add(stockRecord);
//     }catch(e){
//       print('stock data input exception');
//       print(e);
//     }
//   }
//
//   Future<List<StockRecord>> getStockRecordData()async{
//     var stockRecordBox = await getStockRecordBox();
//     List<StockRecord> result = [];
//     result = stockRecordBox.values.map((e) => e).toList();
//     return result;
//   }
//
//
//   //stock history operation
//
//   Future<void> addStockHistoryData(StockHistory stockHistory)async{
//     var stockHistoryBox = getStockHistoryBox();
//     try{
//       await stockHistoryBox.add(stockHistory);
//     }catch(e){
//       print('stock history input exception');
//       print(e);
//     }
//   }
//
//   Future<void> addStockHistoryDataToSpecificRecord(StockRecord stockRecord,StockHistory stockHistory)async{
//     var stockListHistoryBox = getStockListHistoryBox();
//
//
//
//     try{
//       List<StockHistory> lst = stockListHistoryBox.get(stockRecord.id)??[];
//       if(lst.isEmpty){
//         lst = [];
//       }
//       lst.add(stockHistory);
//       await stockListHistoryBox.put(stockRecord.id, lst);
//     }catch(e){
//       print('stock history input exception');
//       print(e);
//     }
//   }
//
//   List<StockHistory> getStockHistoryData(StockRecord stockRecord){
//     var stockListHistoryData = getStockHistoryBox();
//     List<StockHistory> result = [];
//     result = stockListHistoryData.values.where((element) => element.stock_record==stockRecord.id).toList();
//     return result;
//   }
//
//   */
// /*Future<List<StockHistory>> getStockHistoryData()async{
//     var stockHistoryBox = await getStockHistoryBox();
//     List<StockHistory> result = [];
//     result = stockHistoryBox.values.map((e) => e).toList();
//     return result;
//   }*//*
//
//
//   Future<List<StockHistory>> getStockHistoryDataByRecord(StockRecord stockRecord)async{
//     var stockHistoryBox = await getStockHistoryBox();
//     List<StockHistory> result = [];
//     result = stockHistoryBox.values.where((e) => e.stock_record==stockRecord).toList();
//     return result;
//   }
//
//   Future<void> updateUploadedListHistoryItem(StockRecord stockRecord, int i) async{
//     var stockListHistoryBox = await getStockListHistoryBox();
//     try{
//       var lst = stockListHistoryBox.get(stockRecord.id);
//
//       try{
//         lst![i].uploaded=true;
//
//       }catch(e){
//
//       }
//       await stockListHistoryBox.put(stockRecord.id, lst!);
//     }catch(e){
//       print('stock history input exception');
//       print(e);
//     }
//   }
//
//
//
//   Future<void> deleteStockListHistoryItem(StockRecord stockRecord, int i) async{
//     var stockListHistoryBox = await getStockListHistoryBox();
//     try{
//       var lst = stockListHistoryBox.get(stockRecord.id);
//       if(lst==null||lst.isEmpty){
//         lst = [];
//       }
//       try{
//         lst.removeAt(i);
//       }catch(e){
//
//       }
//       await stockListHistoryBox.put(stockRecord.id, lst);
//     }catch(e){
//       print('stock history input exception');
//       print(e);
//     }
//   }
//
//   updateStockHistory(StockRecord stockRecord) async{
//     var stockListHistoryBox = getStockHistoryBox();
//     try{
//       var lst = stockListHistoryBox.values.where((element) => element.stock_record==stockRecord.id && element.uploaded).toList();
//       for (var element in lst) {
//         await element.delete();
//       }
//
//     }catch(e){
//       print('stock history input exception');
//       print(e);
//     }
//   }
//
//   updateUploadedHistoryItems(StockHistory stock) async{
//     stock.uploaded = true;
//     await stock.save();
//   }
//
//
//
//
// }*/
