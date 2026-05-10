import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All
    backgroundColor: "#000000"

    property string surname: ""
    property string name: ""
    property string secondName: ""
    property var noteModel: ListModel {
        ListElement { note: "Иванов Иван Иванович" }
        ListElement { note: "Петров Петр Петрович" }
    }

    // Задание 1
    // Column {
    //     spacing: 50
    //     anchors.centerIn: parent

    //     Button {
    //         text: "Sound Effect"
    //         onClicked: pageStack.push(Qt.resolvedUrl("SoundEffect.qml"))
    //         color: "#755d9a"
    //     }

    //     Button {
    //         text: "Video"
    //         onClicked: pageStack.push(Qt.resolvedUrl("Video.qml"))
    //         color: "#755d9a"
    //     }
    // }

    // Задание 2
    // ListModel {
    //     id: jsonModel
    // }

    // ListView {
    //     anchors.fill: parent
    //     model: jsonModel
    //     spacing: 130

    //     delegate: Item {
    //         Row {
    //             spacing: 30
    //             x: 30

    //             Text {
    //                 text: "ID " + model.id
    //                 color: "#ff6800"
    //                 font.pointSize: 30
    //                 font.family: "monospace"
    //             }

    //             Text {
    //                 text: "Completed " + model.completed
    //                 color: "#4d0000"
    //                 font.pointSize: 30
    //                 font.family: "monospace"
    //             }
    //         }
    //     }
    // }

    // function processData(data) {
    //     jsonModel.clear()
    //     for (var i = 0; i < data.length; i++) {
    //         jsonModel.append({
    //             "id": data[i].id,
    //             "completed": data[i].completed
    //         })
    //     }
    // }

    // Component.onCompleted: {
    //     var request = new XMLHttpRequest()
    //     request.onreadystatechange = function() {
    //         if (request.readyState === XMLHttpRequest.DONE) {
    //             if (request.status === 200) {
    //                 var response = JSON.parse(request.responseText)
    //                 processData(response)
    //             }
    //             else {
    //                 console.error("Failed to fetch JSON data:", request.status, request.statusText);
    //             }
    //         }
    //     }
    //     request.open("GET", "https://jsonplaceholder.typicode.com/todos", true)
    //     request.send()
    // }

    // Задание 3
    function addNote() {
        if (surname != "" && name != "" && secondName != "") {
            noteModel.append({"note": surname + " " + name + " " + secondName})
            noteSurname.text = ""
            noteName.text = ""
            noteSecondName.text = ""
        }
    }

    function deleteNote(index) {
        noteModel.remove(index)
    }

    function initializeDb() {
        var db = LocalStorage.openDatabaseSync("notesDb", "1.0", "Notes Database", 1000000)

        db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS notes(note TEXT)')
            console.log("Таблица создана!")
        })
    }

    SilicaFlickable {
        anchors.fill: parent

        Column {
            id: column
            y: 30
            width: parent.width


            TextField {
                id: noteSurname
                placeholderText: "Фамилия"
                width: parent.width
                onTextChanged: surname = text
                EnterKey.onClicked: noteName.focus = true
                color: "#ffffff"
                placeholderColor: noteSurname.highlighted ? "#d6c7ff" : "#b8b8c8"
            }

            TextField {
                id: noteName
                placeholderText: "Имя"
                width: parent.width
                onTextChanged: name = text
                EnterKey.onClicked: noteSecondName.focus = true
                color: "#ffffff"
                placeholderColor: noteName.highlighted ? "#d6c7ff" : "#b8b8c8"
            }


            TextField {
                id: noteSecondName
                placeholderText: "Отчество"
                width: parent.width
                onTextChanged: secondName = text
                EnterKey.onClicked: focus = false
                color: "#ffffff"
                placeholderColor: noteSecondName.highlighted ? "#d6c7ff" : "#b8b8c8"
            }


            Button {
                id: addButton
                text: "Добавить"
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#ffffff"
                backgroundColor: "#5d3fd3"
                highlightBackgroundColor: "#b4a8e0"
                highlightColor: "#ffffff"
                onClicked: addNote()
            }
        }

        ListView {
            id: noteListView
            width: parent.width
            height: parent.height / 2
            model: noteModel
            anchors.top: column.bottom

            delegate: Item {
                width: parent.width
                height: Theme.itemSizeMedium
                Row {
                    anchors {
                        left: parent.left
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                        margins: Theme.horizontalPageMargin
                    }
                    spacing: Theme.paddingMedium

                    Label {
                        text: model.note
                        wrapMode: Text.Wrap
                        width: parent.width - btnDelete.width - Theme.paddingLarge * 2
                        anchors.verticalCenter: parent.verticalCenter
                        color: "#ffffff"
                        font.family: "Liberation Mono"
                        font.pixelSize: Theme.fontSizeMedium
                    }

                    IconButton {
                        id: btnDelete
                        icon.source: "delete.png"
                        onClicked: deleteNote(index)
                    }
                }
            }
        }
    }

    Component.onCompleted: initializeDb()
}
