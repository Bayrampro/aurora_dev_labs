import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All
    backgroundColor: '#ffffff'

    // Задание 1
    // TextInput {
    //     id: textInput
    //     anchors.centerin: parent
    //     text: "Text"
    // }
    // Button {
    //     anchors.horizontalCenter: parent.horizontalCenter
    //     anchors.top: textInput.bottom
    //     text: "Button"
    //     onClicked: {
    //         console.log(textInput.text)
    //         console.log("Вывод в консоль при нажатии")
    //     }
    // }


    // Задание 2
    // Column {
    //     anchors.centerIn: page
    //     spacing: 50

    //     Rectangle {
    //         id: rect
    //         width: 300
    //         height: 100
    //         color: '#00a86b'
    //     }

    //     Text {
    //         id: text
    //         text: qsTr("Text")
    //     }

    //     Image {
    //         id: img
    //         source: "img/img.jpg"
    //         width: 400
    //         height: 400
    //     }
    // }


    // Задание 3
    Column {
        id: root
        anchors.centerIn: parent
        spacing: 30

        signal buttonOnClicked(int buttonNumber)

        Button {
            text: "Button 1"
            onClicked: root.buttonOnClicked(1)
            backgroundColor: '#00a86b'
        }

        Button {
            text: "Button 2"
            onClicked: root.buttonOnClicked(2)
            backgroundColor: '#00a86b'
        }

        Button {
            text: "Button 3"
            onClicked: root.buttonOnClicked(3)
            backgroundColor: '#00a86b'
        }

        Button {
            text: "Button 4"
            onClicked: root.buttonOnClicked(4)
            backgroundColor: '#00a86b'
        }

        Connections {
            target: root
            onButtonClicked: {
                 console.log("Button", buttonNumber, "clicked!")
            }
        }
    }
}
