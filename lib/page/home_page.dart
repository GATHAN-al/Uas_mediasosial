import 'package:flutter/material.dart';
import 'package:uas_sosialmedia/components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {


  //Buld ui
  @override
  Widget build(BuildContext context) {


    //Scaffold
    return Scaffold(


      //APP Bar
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),

       
      ),

      drawer:const MyDrawer(),
    );
  }
}