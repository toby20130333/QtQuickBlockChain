QT += quick network widgets
CONFIG += c++11
DEFINES += QT_DEPRECATED_WARNINGS


INCLUDEPATH +=$$PWD
include($$PWD/../common.pri)
include($$PWD/../core/core.pri)
include($$PWD/../DDNBlockViews.pri)
include($$PWD/../bip/bip39.pri)

SOURCES += $$PWD/../main.cpp
TARGET = DDNBlockChain
win32:{
    RC_ICONS = $$PWD/../favicon.ico
    LIBS+= -lAdvapi32
}
CONFIG(release, debug|release){
    DESTDIR = $$PWD/../bin
}
CONFIG(debug, debug|release){
    DESTDIR = $$PWD/../bin
}
RESOURCES += $$PWD/../qml.qrc \
    $$PWD/../dd.qrc


CONFIG += console
