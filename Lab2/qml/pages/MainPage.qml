import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All
    backgroundColor: "#ffffff"

    // Задание 1
    // Rectangle {
    //     id: rect
    //     width: 400
    //     height: 100
    //     color: "lightpink"
    //     states: [
    //         State {
    //             name: "clicked"
    //             PropertyChanges {
    //                 target: rect
    //                 x: 300
    //                 y: 1000
    //             }
    //         }
    //     ]


    //     MouseArea {
    //         id: mouseArea
    //         anchors.fill: parent
    //         onClicked: rect.state === "clicked" ? rect.state = "" : rect.state = "clicked"
    //     }
    // }

    // Задание 2
    // Column {
    //     anchors.centerIn: parent
    //     spacing: 300

    //     Rectangle {
    //         id: rect1
    //         color: "lightpink"
    //         width: 200
    //         height: 100

    //         RotationAnimation on rotation {
    //             loops: Animation.Infinite
    //             from: 0
    //             to: 90
    //         }
    //     }

    //     Rectangle {
    //         id: rect2
    //         color: "lightyellow"
    //         width: 200
    //         height: 100

    //         RotationAnimation on rotation {
    //             loops: Animation.Infinite
    //             from: 0
    //             to: 180
    //         }
    //     }

    //     Rectangle {
    //         id: rect3
    //         color: "lightgreen"
    //         width: 200
    //         height: 100

    //         RotationAnimation on rotation {
    //             loops: Animation.Infinite
    //             from: 0
    //             to: 360
    //         }
    //     }
    // }

    // Задание 3
    XmlListModel {
        id: model
        source: "https://cbr.ru/scripts/XML_val.asp?d=O"
        query: "/Valuta/Item"

        XmlRole { name: "name"; query: "Name/string()" }
        XmlRole { name: "nominal"; query: "Nominal/string()" }
        XmlRole { name: "parentCode"; query: "ParentCode/string()" }

        onStatusChanged: {
            if (status === XmlListModel.Ready) {
                console.log("Got", count, "Market Lib")
            } else if (status == XmlListModel.Error) {
                console.log("Error loading Market Libs:", errorString())
            }
        }
    }

    ListView {
        anchors.fill: parent
        model: model
        spacing: 100
        delegate: Item {
            width: parent.width
            height: 100
            Column {
                Text {
                    text: "Name: " + name
                }
                Text {
                    text: "Nominal: " + nominal
                }
                Text {
                    text: "ParentCode: " + parentCode
                }
            }
        }
    }
}
