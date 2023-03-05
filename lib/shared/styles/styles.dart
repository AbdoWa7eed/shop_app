

// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData appTheme = ThemeData(
              fontFamily: 'Jannah',
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
                primarySwatch: Colors.deepPurple,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepPurple[900]),
                scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepPurple[900],
                 elevation: 20
                ),
                appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.black),
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        //   statusBarBrightness: Brightness.dark,
                        statusBarIconBrightness: Brightness.dark),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    backwardsCompatibility: false));
