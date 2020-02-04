import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseConnector{
  static final FirebaseDatabaseConnector _database = FirebaseDatabaseConnector._internal();
  FirebaseApp app;
  FirebaseDatabase db;
  bool initComplete = false;

  FirebaseDatabaseConnector._internal();

  static FirebaseDatabaseConnector get(){
    return _database;
  }

  Future _init() async {
    app = await FirebaseApp.configure(
      name: 'db2',
      options: const FirebaseOptions(
        googleAppID: "Your Google App ID",
        apiKey: "Your Google API Key",
        databaseURL: "Your Firebase Realtime Database URL",
        ),
    );
    db = FirebaseDatabase(app: this.app);
    initComplete = true;
  }

  Future<FirebaseDatabase> _getDB() async {
    if(!initComplete)
      await _init();
    return db;
  }

  Future getData(String location) async {
    var db = await _getDB();
    
    var res = await db.reference().child(location).once();

    return res.value;
  }
}