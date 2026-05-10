TARGET = com.byprogger.Lab4

CONFIG += \
    auroraapp

PKGCONFIG += \

SOURCES += \
    src/main.cpp \

HEADERS += \

DISTFILES += \
    qml/pages/audio.wav \
    qml/pages/video.avi \
    qml/pages/SoundEffect.qml \
    qml/pages/Video.qml \
    rpm/com.byprogger.Lab4.spec \

AURORAAPP_ICONS = 86x86 108x108 128x128 172x172

CONFIG += auroraapp_i18n

TRANSLATIONS += \
    translations/com.byprogger.Lab4.ts \
    translations/com.byprogger.Lab4-ru.ts \

QT += multimedia
