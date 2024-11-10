import 'package:crud_mongodb/pet_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;


class MongoService {

  static final MongoService _instance = MongoService._internal();
  late mongo.Db _db;

  MongoService._internal();

  factory MongoService(){
    return _instance;
  }

  Future<void> connect() async{
    _db = await mongo.Db.create('mongodb+srv://msanchezpapalotzi:ATcYvBEjpJBzYi7c@clustermigue.felga.mongodb.net/pets_db?retryWrites=true&w=majority&appName=ClusterMigue');
    await _db.open();
  }

  mongo.Db get db{
    if(!_db.isConnected){
      throw StateError('Base de datos no inicializada, llama a connect() primero');
    }
    return _db;
  }
  // mongo.Db get db => _db;

  Future<void> insertPet(PetModel pet) async{
    var collection = _db.collection('pets');
    await collection.insertOne(pet.toJson());
  }

  Future<void> updatePet(PetModel pet)async{
    var collection = _db.collection('pets');
    await collection.updateOne(
      mongo.where.eq('_id', pet.id), 
      mongo.modify.set('name', pet.name).set('type', pet.type),
      );
  }

  Future<void> deletePet(mongo.ObjectId id) async{
    var collection = _db.collection('pets');
    await collection.remove(mongo.where.eq('_id', id));
  }

  Future<List<PetModel>> getPets() async{
    var collection = db.collection('pets');
    var pets = await collection.find().toList();
    return pets.map((pet) => PetModel.fromJson(pet)).toList();
  }
}