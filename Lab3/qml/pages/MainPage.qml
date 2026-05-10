import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All
    backgroundColor: "#ffffff"

    PageHeader {
        objectName: "pageHeader"
        title: "Page" + pageStack.depth
    }

    // Задание 1
    // Column {
    //     width: parent.width
    //     spacing: Theme.paddingLarge
    //     anchors.centerIn: parent


    //     Button {
    //         text: "Вперед"
    //         anchors.horizontalCenter: parent.horizontalCenter
    //         onClicked: pageStack.push(Qt.resolvedUrl("MainPage.qml"))
    //         backgroundColor: "lightpink"
    //     }

    //     Button {
    //         text: "Назад"
    //         anchors.horizontalCenter: parent.horizontalCenter
    //         onClicked: pageStack.pop()
    //         backgroundColor: "lightyellow"
    //     }
    // }

    // Задание 2
    // Loader {
    //     id: rect
    //     anchors.centerIn: parent
    //     source: "RectComponent.qml"
    // }

    // Задание 3
    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuLabel { text: "Информационная ветка" }

            MenuItem {
                text: "Действие 1"
                onClicked: {
                    console.log("Действие 1")
                    slider.value = 20
                }
            }

            MenuItem {
                text: "Действие 2"
                onClicked: {
                    console.log("Действие 2")
                    slider.value = 40
                }
            }

            MenuItem {
                text: "Действие 3"
                onClicked: {
                    console.log("Действие 3")
                    slider.value = 60
                }
            }
        }

        Slider {
            id: slider
            width: parent.width
            maximumValue: 100
            minimumValue: 0
            value: 0
        }
    }
}
