import 'package:crud_mongodb/mongo_service.dart';
import 'package:crud_mongodb/pet_model.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class InsertPetScreen extends StatefulWidget {
  const InsertPetScreen({super.key});

  @override
  State<InsertPetScreen> createState() => _InsertPetScreenState();
}

class _InsertPetScreenState extends State<InsertPetScreen> {
  late TextEditingController _nameController;
  late TextEditingController _typeController;

  @override
  void initState(){
    super.initState();
    _nameController = TextEditingController();
    _typeController = TextEditingController();
  }

  @override
  void dispose(){
    _nameController = TextEditingController();
    _typeController = TextEditingController();
    super.dispose();
  }

  void _inserPet() async{
    var pet = PetModel(
      id: mongo.ObjectId(), 
      name: _nameController.text, 
      type: _typeController.text,
      );
      await MongoService().insertPet(pet);
      if(!mounted) return;
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}