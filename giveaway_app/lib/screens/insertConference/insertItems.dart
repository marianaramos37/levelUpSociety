import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnDelete();

class InsertItems extends StatefulWidget {
  List<String> speakers;
  InsertItems({Key key, this.speakers}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InsertItems();
  }
}

class _InsertItems extends State<InsertItems> {
  List<SpeakerForm> speakersForms = [];

  @override
  void initState() {
    super.initState();

    // add previous forms
    for (var spk in widget.speakers) {
      speakersForms.add(new SpeakerForm(
        speaker: spk,
        onDelete: () => onDelete(spk),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: <Widget>[
        // Header
        Container(
          width: MediaQuery.of(context).size.width,
          child: Image.asset('images/pageHeader.png', fit: BoxFit.fill),
        ),

        // Title
        Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.08,
              right: MediaQuery.of(context).size.width * 0.08,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Insert Donation Items",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Color(0xFFec5568),
                        fontSize: 32.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                    child: speakersForms.length <= 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                                "Add an donation item by tapping + button",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: 'Rubik',
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w400)),
                          )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            addAutomaticKeepAlives: true,
                            itemCount: speakersForms.length,
                            itemBuilder: (_, i) => speakersForms[i],
                          ),
                  )
                ])),

        SizedBox(height: 50),
      ]),
      floatingActionButton: Stack(children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              heroTag: "btn1",
              child: Icon(Icons.add),
              backgroundColor: Color(0xFFe9bf87),
              onPressed: onAddForm,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: "btn2",
            child: Icon(Icons.done),
            backgroundColor: Color(0xFFe9bf87),
            onPressed: onSave,
            foregroundColor: Colors.white,
          ),
        ),
      ]),
    );
  }

  //on add form
  void onAddForm() {
    setState(() {
      var _speaker = "";
      speakersForms.add(SpeakerForm(
        speaker: _speaker,
        onDelete: () => onDelete(_speaker),
      ));
    });
  }

  //on form user deleted
  void onDelete(String _speaker) {
    setState(() {
      var find = speakersForms.firstWhere(
        (it) => it.speaker == _speaker,
        orElse: () => null,
      );
      if (find != null) speakersForms.removeAt(speakersForms.indexOf(find));
    });
  }

  //on save forms
  void onSave() {
    if (speakersForms.length > 0) {
      var allValid = true;
      speakersForms.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        widget.speakers = speakersForms.map((it) => it.speaker).toList();
        Navigator.pop(context, widget.speakers);
      }
    }
  }
}

class SpeakerForm extends StatefulWidget {
  String speaker;
  final state = _SpeakerFormState();
  final OnDelete onDelete;

  SpeakerForm({Key key, this.speaker, this.onDelete}) : super(key: key);
  @override
  _SpeakerFormState createState() => state;

  bool isValid() => state.validate();
}

class _SpeakerFormState extends State<SpeakerForm> {
  final form = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: form,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                title: Text('Item'),
                backgroundColor: Color(0xFFec5568),
                automaticallyImplyLeading: false,
              ),
              TextFormField(
                initialValue: widget.speaker,
                onSaved: (val) => widget.speaker = val,
                validator: (val) =>
                    val.length > 2 ? null : 'Item\'s name is invalid',
                decoration: InputDecoration(
                  labelText: 'Item\'s name',
                  hintText: 'Item\'s name',
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }

  // form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}
