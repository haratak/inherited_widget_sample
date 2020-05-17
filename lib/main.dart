import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage('Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('InheritedWidgetの場合'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopPage1(),
                    fullscreenDialog: true,
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class TopPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _HomePage(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('InheritedWidget Demo'),
        ),
        body: Column(
          children: <Widget>[
            _WidgetA(),
            _WidgetB(),
            _WidgetC(),
          ],
        ),
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  _HomePage({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  __HomePageState createState() => __HomePageState();

  static __HomePageState of(BuildContext context, {bool rebuild = true}) {
    if (rebuild) {
      return (context.dependOnInheritedWidgetOfExactType<_MyInheritedWidget>())
          .data;
    }
    return (context
            .getElementForInheritedWidgetOfExactType<_MyInheritedWidget>()
            .widget as _MyInheritedWidget)
        .data;
  }
}

class __HomePageState extends State<_HomePage> {
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _MyInheritedWidget extends InheritedWidget {
  const _MyInheritedWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final __HomePageState data;

  static _MyInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(_MyInheritedWidget)
        as _MyInheritedWidget;
  }

  @override
  bool updateShouldNotify(_MyInheritedWidget old) {
    return true;
  }
}

class _WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('called  _WidgetA#build()');
    final __HomePageState state = _HomePage.of(context);

    return Center(
      child: Text(
        '${state.counter}',
        style: Theme.of(context).textTheme.display1,
      ),
    );
  }
}

class _WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('called _WidgetB#build()');
    return const Text('I am a widget that will not be rebuilt.');
  }
}

class _WidgetC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('called _WidgetC#build()');
    final __HomePageState state = _HomePage.of(context, rebuild: false);
    return RaisedButton(
      onPressed: () {
        state._incrementCounter();
      },
      child: Icon(Icons.add),
    );
  }
}
