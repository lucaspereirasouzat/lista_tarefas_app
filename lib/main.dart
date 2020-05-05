import 'package:flutter/material.dart';
import 'tarefa.dart';

void main() {
  runApp(new ListaTarefaApp());
}

class ListaTarefaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new ListaScreen());
  }
}

class ListaScreen extends StatefulWidget {
  // @overrite
  State<StatefulWidget> createState() {
    return new ListaScreenState();
  }
}

class ListaScreenState extends State<ListaScreen> {
  TextEditingController controller = new TextEditingController();
  List<Tarefa> tarefas = new List<Tarefa>();

  void adicionaTarefa(String nome) {
    setState(() {
      tarefas.add(Tarefa(nome));
    });
    controller.clear();
  }

  Widget getItem(Tarefa tarefa) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: new Icon(
            tarefa.concluida ? Icons.check_box : Icons.check_box_outline_blank,
            color: tarefa.concluida ? Colors.green : Colors.grey,
          ),
          iconSize: 42.0,
          onPressed: () {
            setState(() {
              tarefa.concluida = !tarefa.concluida;
            });
          },
        ),
        new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(tarefa.nome),
          Text(tarefa.data.toLocal().toString()
              //  tarefa.data.toIso8601String()
              )
        ]),
        IconButton(
          // alignment: Alingment.center,
          onPressed: () => setState(() {
            tarefas.removeWhere((item) => item == tarefa);
          }),
          icon: new Icon(
            Icons.close,
            color: Colors.red,
            size: 42.0,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Lista de Tarefas"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Digite a tarefa aqui'),
              controller: controller,
              onSubmitted: adicionaTarefa,
            ),
          ),
          Expanded(
            child: tarefas.length == 0
                ? Text("Nenhuma tarefa criada")
                : ListView.builder(
                    itemCount: tarefas.length,
                    itemBuilder: (_, index) => getItem(tarefas[index]),
                  ),
          )
        ],
      ),
    );
  }
}
