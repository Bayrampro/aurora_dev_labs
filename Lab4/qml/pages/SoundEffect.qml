import QtQuick 2.0
import QtMultimedia 5.6 as Multimedia
import Sailfish.Silica 1.0

Page {
    objectName: "soundEffectPage"
    allowedOrientations: Orientation.All
    backgroundColor: "#ffffff"

    Multimedia.SoundEffect {
        id: sound
        source: "audio.wav"
    }

    Column {
        anchors.centerIn: parent
        width: parent.width

        Button {
           id: btn
           text: "Play Sound Effect"
           anchors.horizontalCenter: parent.horizontalCenter
           onClicked: sound.play()
           backgroundColor: "#785394"
        }

        Slider {
            id: volumeSlider
            label: "звук"
            value: 1.0
            valueText: value
            minimumValue: 0
            maximumValue: 1.0
            stepSize: 0.1
            width: parent.width - Theme.paddingLarge * 2
            onValueChanged: sound.volume = value
        }

        Slider {
            id: repeatSlider
            label: "кол-во повторений"
            value: 1.0
            valueText: value
            minimumValue: 0
            maximumValue: 10
            stepSize: 1
            width: parent.width - Theme.paddingLarge * 2
            onValueChanged: sound.loops = value
        }
    }
}
