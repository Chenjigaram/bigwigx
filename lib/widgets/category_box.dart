import 'package:bigwigx/models/category.dart';
import 'package:bigwigx/screens/search.dart';
import 'package:flutter/material.dart';

List<Color> colorList = [
  Colors.pink.shade200,
  Colors.cyan.shade200,
  Colors.orange.shade300,
  Colors.indigo.shade200,
  Colors.green.shade300,
  Colors.red.shade300,
  Colors.pink.shade200,
  Colors.cyan.shade200,
  Colors.orange.shade300,
  Colors.indigo.shade200,
  Colors.green.shade300,
  Colors.red.shade300,
  Colors.pink.shade200,
  Colors.cyan.shade200,
  Colors.orange.shade300,
  Colors.indigo.shade200,
  Colors.green.shade300,
  Colors.red.shade300
];

Widget categoryBox(int index, BuildContext context, Size _deviceSize,
    List<Category> categories) {
  if (index > categories.length - 1) {
    return GestureDetector(
        onTap: () {
          print("category clicked");
          MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => BookSearch(searchString: "All",));
          Navigator.of(context).push(route);
        },
        child: Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: colorList[index],
            ),
            child: Stack(children: [
              Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Search By Category',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          Text('A-Z',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600)),
                        ]),
                  )),
            ])));
  }
  return GestureDetector(
      onTap: () {
        print("category clicked 1");
        MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => BookSearch(searchString: categories[index].name,));
        Navigator.of(context).push(route);
      },
      child: Container(
          margin: EdgeInsets.all(5.0),
          width: _deviceSize.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(image:
            AssetImage(categories[index].image),
                fit: BoxFit.fill),
          ),
          child: Stack(children: [
            Container(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                categories[index].name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.end,
              ),
            ),
          ])));
}
