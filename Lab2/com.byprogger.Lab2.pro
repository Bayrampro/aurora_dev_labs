TARGET = com.byprogger.Lab2

CONFIG += \
    auroraapp

PKGCONFIG += \

SOURCES += \
    src/main.cpp \

HEADERS += \

DISTFILES += \
    rpm/com.byprogger.Lab2.spec \

AURORAAPP_ICONS = 86x86 108x108 128x128 172x172

CONFIG += auroraapp_i18n

TRANSLATIONS += \
    translations/com.byprogger.Lab2.ts \
    translations/com.byprogger.Lab2-ru.ts \

QT += xmlpatterns
