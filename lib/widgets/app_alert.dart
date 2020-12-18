import 'package:flutter/material.dart';

class AlertWidget extends Dialog {
  String title = '';
  String message = '';
  String confirm = '确定';
  VoidCallback confirmCallback;
  VoidCallback cancelCallback;

  AlertWidget(
      {this.title,
      this.message,
      this.cancelCallback,
      this.confirmCallback,
      this.confirm});
  @override
  Widget build(BuildContext context) {
    return Material(
//        type: MaterialType.transparency,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Center(
        child: Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(message),
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 1,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: FlatButton(
                            child: Text('取消'),
                            onPressed: cancelCallback == null
                                ? () {
                                    Navigator.pop(context);
                                  }
                                : cancelCallback,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1, color: Color(0xffEFEFF4))),
                          ),
                        )),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        child: Text(
                          confirm,
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          confirmCallback();
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
