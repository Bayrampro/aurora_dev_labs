# Лабораторная работа №17 — Мультимедиа, JSON и локальное хранилище в Aurora OS

**Дисциплина:** Программирование мобильных устройств  
**Студент:** Аннагурбанов Байрам  
**Группа:** ИНС-б-о-24-2  
**Дата рождения:** 12.10.2002  
**СКФУ, 2026**

## Цель работы

Изучить работу с мультимедийными возможностями QML, загрузку и отображение данных из JSON-источника, а также использование локального хранилища `LocalStorage` при разработке мобильного приложения для Aurora OS.

## Задания по методичке

В рамках лабораторной работы необходимо было выполнить три задания:

1. Реализовать работу с мультимедиа: воспроизведение звукового эффекта и видеофайла.
2. Получить JSON-данные из внешнего источника, обработать их и вывести в список.
3. Создать форму для ввода данных, список записей и подготовить локальную базу данных через `LocalStorage`.

## Ход выполнения работы

Проект создан как приложение Aurora OS. Точка входа находится в файле `src/main.cpp`. В нем создается объект приложения, задаются имя организации и имя приложения, после чего загружается QML-интерфейс:

```cpp
view->setSource(Aurora::Application::pathTo(QStringLiteral("qml/Lab4.qml")));
```

Главный QML-файл `qml/Lab4.qml` описывает окно приложения `ApplicationWindow`, задает начальную страницу `pages/MainPage.qml` и страницу обложки `cover/DefaultCoverPage.qml`.

Для работы с мультимедиа в файле проекта `com.byprogger.Lab4.pro` подключен модуль:

```pro
QT += multimedia
```

Также в проект добавлены мультимедийные файлы:

```pro
DISTFILES += \
    qml/pages/audio.wav \
    qml/pages/video.avi \
```

В `.spec`-файле указаны зависимости Qt Multimedia, необходимые для запуска приложения на Aurora OS:

```spec
Requires:   qt5-qtmultimedia
Requires:   qt5-qtdeclarative-import-multimedia
Requires:   qt5-qtmultimedia-plugin-mediaservice-gstmediacapture
Requires:   qt5-qtmultimedia-plugin-mediaservice-gstmediaplayer
BuildRequires:  pkgconfig(Qt5Multimedia)
```

### Задание 1. Воспроизведение звука и видео

В первом задании была подготовлена навигация с главной страницы к двум отдельным страницам: `SoundEffect.qml` и `Video.qml`.

```qml
Button {
    text: "Sound Effect"
    onClicked: pageStack.push(Qt.resolvedUrl("SoundEffect.qml"))
}

Button {
    text: "Video"
    onClicked: pageStack.push(Qt.resolvedUrl("Video.qml"))
}
```

На странице `SoundEffect.qml` используется компонент `SoundEffect` из модуля `QtMultimedia`. Он подключает файл `audio.wav`:

```qml
Multimedia.SoundEffect {
    id: sound
    source: "audio.wav"
}
```

Для воспроизведения добавлена кнопка:

```qml
Button {
   text: "Play Sound Effect"
   onClicked: sound.play()
}
```

Также на странице размещены два слайдера. Первый изменяет громкость:

```qml
Slider {
    id: volumeSlider
    label: "звук"
    minimumValue: 0
    maximumValue: 1.0
    stepSize: 0.1
    onValueChanged: sound.volume = value
}
```

Второй слайдер задает количество повторений:

```qml
Slider {
    id: repeatSlider
    label: "кол-во повторений"
    minimumValue: 0
    maximumValue: 10
    stepSize: 1
    onValueChanged: sound.loops = value
}
```

Для воспроизведения видео создана страница `Video.qml`. В ней используется компонент `Video`, который загружает файл `video.avi`:

```qml
Multimedia.Video {
    id: videoPlayer
    width: parent.width
    height: parent.height
    source: "video.avi"
    autoPlay: true
}
```

Для управления воспроизведением добавлены кнопки `Пауза/Воспроизведение` и `Стоп`. Кнопка запуска и паузы проверяет текущее состояние плеера:

```qml
if (videoPlayer.playbackState === Multimedia.MediaPlayer.PlayingState) {
    videoPlayer.pause()
} else {
    videoPlayer.play()
}
```

Результат выполнения первого задания: приложение умеет открывать страницу звукового эффекта, воспроизводить WAV-файл, изменять громкость и количество повторений, а также открывать страницу с AVI-видео и управлять воспроизведением.

### Задание 2. Загрузка и отображение JSON

Во втором задании была подготовлена модель `ListModel` для хранения данных, полученных из JSON:

```qml
ListModel {
    id: jsonModel
}
```

Для вывода данных используется `ListView`, которому передается модель `jsonModel`:

```qml
ListView {
    anchors.fill: parent
    model: jsonModel

    delegate: Item {
        Row {
            Text {
                text: "ID " + model.id
            }

            Text {
                text: "Completed " + model.completed
            }
        }
    }
}
```

Получение данных выполняется через `XMLHttpRequest`. В качестве источника используется сервис `jsonplaceholder.typicode.com/todos`:

```qml
Component.onCompleted: {
    var request = new XMLHttpRequest()
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status === 200) {
                var response = JSON.parse(request.responseText)
                processData(response)
            }
        }
    }
    request.open("GET", "https://jsonplaceholder.typicode.com/todos", true)
    request.send()
}
```

Функция `processData()` очищает модель и добавляет в нее данные из JSON-массива:

```qml
function processData(data) {
    jsonModel.clear()
    for (var i = 0; i < data.length; i++) {
        jsonModel.append({
            "id": data[i].id,
            "completed": data[i].completed
        })
    }
}
```

Результат выполнения второго задания: приложение получает JSON-данные из внешнего источника, преобразует их в элементы `ListModel` и выводит через `ListView`.

### Задание 3. Форма, список и LocalStorage

В третьем задании была реализована форма для ввода ФИО и список записей. Для хранения текущего ввода используются свойства страницы:

```qml
property string surname: ""
property string name: ""
property string secondName: ""
```

Для отображения записей используется модель `noteModel`:

```qml
property var noteModel: ListModel {
    ListElement { note: "Иванов Иван Иванович" }
    ListElement { note: "Петров Петр Петрович" }
}
```

На странице размещены три поля `TextField`: фамилия, имя и отчество. Введенный текст сохраняется в свойства страницы:

```qml
TextField {
    id: noteSurname
    placeholderText: "Фамилия"
    onTextChanged: surname = text
}

TextField {
    id: noteName
    placeholderText: "Имя"
    onTextChanged: name = text
}

TextField {
    id: noteSecondName
    placeholderText: "Отчество"
    onTextChanged: secondName = text
}
```

При нажатии на кнопку `Добавить` вызывается функция `addNote()`:

```qml
function addNote() {
    if (surname != "" && name != "" && secondName != "") {
        noteModel.append({"note": surname + " " + name + " " + secondName})
        noteSurname.text = ""
        noteName.text = ""
        noteSecondName.text = ""
    }
}
```

Для удаления записи используется функция `deleteNote()`:

```qml
function deleteNote(index) {
    noteModel.remove(index)
}
```

Список записей выводится через `ListView`. В делегате отображается текст записи и кнопка удаления:

```qml
ListView {
    id: noteListView
    model: noteModel

    delegate: Item {
        Row {
            Label {
                text: model.note
            }

            IconButton {
                icon.source: "delete.png"
                onClicked: deleteNote(index)
            }
        }
    }
}
```

Также подключен модуль локального хранилища:

```qml
import QtQuick.LocalStorage 2.0
```

При запуске страницы создается база данных `notesDb` и таблица `notes`:

```qml
function initializeDb() {
    var db = LocalStorage.openDatabaseSync("notesDb", "1.0", "Notes Database", 1000000)

    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS notes(note TEXT)')
        console.log("Таблица создана!")
    })
}

Component.onCompleted: initializeDb()
```

Результат выполнения третьего задания: создан интерфейс для ввода ФИО, добавления записи в список, удаления записей и инициализации локальной базы данных.

## Результат работы

В ходе лабораторной работы было создано мобильное приложение для Aurora OS. В приложении были выполнены все три задания из методички:

- подключен модуль `QtMultimedia`;
- добавлены WAV- и AVI-файлы в проект;
- реализовано воспроизведение звукового эффекта;
- реализовано воспроизведение видео и управление плеером;
- подготовлена загрузка JSON через `XMLHttpRequest`;
- реализован вывод JSON-данных через `ListView`;
- создана форма ввода ФИО;
- реализованы добавление и удаление записей;
- подключено локальное хранилище `LocalStorage`;
- создана локальная таблица `notes`.

## Вывод

В результате выполнения лабораторной работы были изучены мультимедийные возможности QML, работа с внешними JSON-данными и базовые операции с локальным хранилищем в Aurora OS. Также были закреплены навыки построения интерфейса с несколькими страницами, списками, формами ввода и обработчиками пользовательских действий.
