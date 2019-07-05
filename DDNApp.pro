QT += quick network widgets
CONFIG += c++11
DEFINES += QT_DEPRECATED_WARNINGS

include(common.pri)
include(core/core.pri)
include(DDNBlockViews.pri)
include(bip/bip39.pri)

SOURCES += main.cpp

win32:{
    RC_ICONS = favicon.ico
    LIBS+= -lAdvapi32
}
CONFIG(release, debug|release){
    DESTDIR = $$PWD/../bin
}
RESOURCES += qml.qrc \
    dd.qrc
