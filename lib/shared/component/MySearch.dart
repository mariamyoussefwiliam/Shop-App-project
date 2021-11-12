import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySearch extends StatefulWidget {
  @override
  _MySearchState createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  bool Width = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: Width ? 46 : MediaQuery.of(context).size.width * 0.7,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        boxShadow: kElevationToShadow[6],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              child: !Width
                  ? TextField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.blue[300]),
                          border: InputBorder.none),
                    )
                  : null,
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(

                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Icon(Width ? Icons.search : Icons.close,color: Colors.white,),
                ),
                onTap: () {
                  setState(() {
                    Width = !Width;
                  });
                },
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.blue[300],
              boxShadow: kElevationToShadow[6],
            ),
          ),
        ],
      ),
    );
  }
}
