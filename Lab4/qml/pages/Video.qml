import QtQuick 2.0
import QtMultimedia 5.6 as Multimedia
import Sailfish.Silica 1.0

Page {
    id: videoPlayerPage
    objectName: "videoPage"
    allowedOrientations: Orientation.All
    backgroundColor: "#ffffff"


    Multimedia.Video {
        id: videoPlayer
        width: parent.width
        height: parent.height
        source: "video.avi"
        autoPlay: true
    }

    Button {
        id: playPauseButton
        width: parent.width
        height: Theme.itemSizeLarge
        backgroundColor: "#785394"
        anchors.bottom: parent.bottom
        text: videoPlayer.playbackState === Multimedia.MediaPlayer.PlayingState ? "Пауза" : "Воспроизведение"
        onClicked: {
            if (videoPlayer.playbackState === Multimedia.MediaPlayer.PlayingState) {
                videoPlayer.pause()
                playPauseButton.text = "Воспроизведение"
            } else {
                videoPlayer.play()
                playPauseButton.text = "Пауза"
            }
        }
    }


    Button {
        id: rewindButton
        width: parent.width
        height: Theme.itemSizeLarge
        backgroundColor: "#785394"
        anchors.bottom: playPauseButton.top
        text: "Стоп"
        onClicked: {
            videoPlayer.stop()
        }
    }
}
