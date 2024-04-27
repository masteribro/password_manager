import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordTiles extends StatelessWidget {
  const PasswordTiles({super.key, this.email, this.siteName, this.name, this.onTap});
  final String? email;
  final String? siteName;
  final String? name;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
              )]),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      height: 60,
                      width: 60,
                      child: Image.asset(name!)),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(siteName!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                      const SizedBox(height: 2,),
                      Text(email!,
                          style: const TextStyle(
                            color: Colors.grey,
                          )
                      ),
                    ],
                  ),
                ]
              ),

              GestureDetector(
                  onTap: onTap,
                  child: const Icon(Icons.copy))
            ],
          ),
        )

    );
  }
}
