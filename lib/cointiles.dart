import 'package:flutter/material.dart';

class CointileDesign extends StatelessWidget {
  CointileDesign({Key? key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.change,
    required this.changePercentage,
  }) : super(key: key);

  String name;
  String symbol;
  String imageUrl;
  double change;
  double changePercentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        height: MediaQuery.of(context).size.height / 10,

        decoration: const BoxDecoration(
          color: Colors.transparent,


        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(imageUrl),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Color(
                            0xff000000),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    symbol,
                    style: const TextStyle(
                      color: Color(
                          0xff252524),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    change.toDouble() < 0
                        ? change.toDouble().toString()
                        : '+${change.toDouble()}',
                    style: TextStyle(
                      color: change.toDouble() < 0 ? Colors.red : const Color(
                          0xff252524),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    changePercentage.toDouble() < 0
                        ? '${changePercentage.toDouble()}%'
                        : '+${changePercentage.toDouble()}%',
                    style: TextStyle(
                      color: changePercentage.toDouble() < 0
                          ? Colors.red
                          : const Color(
                          0xff252524),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}