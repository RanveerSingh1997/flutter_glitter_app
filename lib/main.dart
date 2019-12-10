import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
const _height=600.0;
const _width=300.0;
const _duration=Duration(microseconds:500);
final random=math.Random();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Color _randomColor(){
    return Color.fromARGB(255,random.nextInt(255),random.nextInt(255),random.nextInt(255));
  }


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: _duration,
    );
    _controller.addStatusListener((AnimationStatus status){
      if(status==AnimationStatus.completed){
        _controller.reverse();
      }else if(status==AnimationStatus.dismissed){
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  List<Widget>  _createGlitterPieces(int numbPieces) {
    final pieces=<Widget>[];

    for(var i=0;i<numbPieces;i++){
      pieces.add(_createStaticGlitterPiece());
    }

    for(var i=0;i<numbPieces;i++){
      pieces.add(_createAnimatedGlitterPiece());
    }

    for(var i=0;i<numbPieces;i++){
      pieces.add(_createStaticAnimatedGlitterPiece());
    }

    return pieces;
  }

  Widget _createStaticGlitterPiece() {
    final pieceSize=4.0;
    final _colorTween=ColorTween(begin:_randomColor(),end:Colors.transparent);
    final Animation   _animation = _colorTween.animate(_controller);
    final piece=AnimatedBuilder(
          animation:_animation,
          builder: (BuildContext context,Widget widget){
            return Container(height:pieceSize ,width: pieceSize,color:_animation.value);
          },
    );
    final topOffset=random.nextDouble()*(_height-pieceSize);
    final leftOffset=random.nextDouble()*(_width-pieceSize);
    return Positioned(
      top: topOffset,
      left: leftOffset,
      child: piece,
    );
  }

  Widget _createStaticAnimatedGlitterPiece() {
    final random=math.Random();
    final pieceSize=4.0;
    final _colorTween=ColorTween(begin:Colors.transparent,end:_randomColor());
    final Animation  _animation = _colorTween.animate(_controller);
    final piece=AnimatedBuilder(
      animation:_animation,
      builder: (BuildContext context,Widget widget){
        return Container(height:pieceSize ,width: pieceSize,color:_animation.value);
      },
    );
    final topOffset=random.nextDouble()*(_height-pieceSize);
    final leftOffset=random.nextDouble()*(_width-pieceSize);
    return Positioned(
      top: topOffset,
      left: leftOffset,
      child: piece,
    );
  }


  Widget _createAnimatedGlitterPiece() {
    final random=math.Random();
    final pieceSize=2.0;
    final piece=Container(height:pieceSize ,width: pieceSize,color:Colors.green,);
    final topOffset=random.nextDouble()*(_height-pieceSize);
    final leftOffset=random.nextDouble()*(_width-pieceSize);
    return Positioned(
      top: topOffset,
      left: leftOffset,
      child: piece,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height:_height,
          width: _width,
          color: Colors.pink[100],
          child: Stack(
            children:_createGlitterPieces(1500),
          ),
        ),
      ),
    );
  }
}
