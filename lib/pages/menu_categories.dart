import 'package:flutter/material.dart';
import 'package:scanner_app/pages/category_button.dart';
import 'package:scanner_app/pages/doucument_category.dart';

class MenuCategories extends StatelessWidget {
  const MenuCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(child: CategoryButton(imagepath: null, label: 'Kartu', onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DoucumentCategoryPage(categoryTitle:'Kartu')));
        })),
        Flexible(child: CategoryButton(imagepath: null, label: 'Nota', onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>DoucumentCategoryPage(categoryTitle:'Nota')));})),
         Flexible(child: CategoryButton(imagepath: null, label: 'Surat', onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>DoucumentCategoryPage(categoryTitle:'Surat')));})),
      ],
    );
  }
}