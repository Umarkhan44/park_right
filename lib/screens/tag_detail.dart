import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'home_screen.dart';


class TagDatil extends StatefulWidget {

  final  formattedTime;
  final  frontImages;
  final  backImages;
  final  selectedValue;
  final  Approved;
  final  Denied;

  const TagDatil({
    Key? key,
     this.formattedTime,
     this.frontImages,
     this.backImages,  this.selectedValue,
     this.Approved,
     this.Denied,
  }) : super(key: key);

  @override
  State<TagDatil> createState() => _TagDatilState();

}

class _TagDatilState extends State<TagDatil> {
  String getStatusText() {
    if (widget.Approved == true) {
      return 'Approved';
    } else if (widget.Denied == true) {
      return 'Denied';
    } else {
      return 'Requested';
    }
  }
  Color getStatusColor() {
    if (widget.Approved == true) {
      return Colors.green;
    } else if (widget.Denied == true) {
      return Colors.red;
    } else {
      return Color(0xff165E96);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4.0,
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
        ),
        titleSpacing: 0.0, // Set the title spacing to 0
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.selectedValue,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 3),
            Row(
              children: [
                Text(
                  '19 Jun, 2022 11:50',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 4,),

                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getStatusColor(),
                  ),
                ),
                SizedBox(width: 4,),
                Text(
                  getStatusText(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: getStatusColor(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),



      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Front or back image (with plate)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
            ),
            SizedBox(height: 13,),
            Expanded(
              child: SizedBox(
                height: 177,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.frontImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                     width : 145,
                    height: 176,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14.0),
                        child: widget.frontImages[index] != null
                            ? Image.network(
                          widget.frontImages[index],
                          fit: BoxFit.cover,
                          width: 155,
                          height: 176,
                        )
                            : Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
           SizedBox(height: 13,),
            Text(
              'Side or 45° image (with problem)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
            ),
            SizedBox(height: 13,),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: widget.backImages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 25.0,
                  mainAxisSpacing: 15.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 155,
                    width: 176,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.0),
                      child: widget.backImages[index] != null
                          ? Image.network(
                        widget.backImages[index],
                        fit: BoxFit.cover,
                        height: 155,
                        width: 176,
                      ) : Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  );



                },
              ),

            ),
          ],
        ),
      ),
    );
  }
}
