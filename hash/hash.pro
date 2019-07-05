include(../common.pri)

TARGET = QtCryptoHash$${ARCH_SUFFIX}

QT      -= gui

TEMPLATE = lib

INCLUDEPATH += ./include/ \
               ./3rdparty/include

SOURCES += \
           src/rmd160.cpp \
           src/tiger.cpp \
           src/whirlpool.cpp \
           src/qcryptohash.cpp \
           src/hashalgorithm.cpp \
    src/base58.c

HEADERS += \
           include/rmd160.hpp \
           include/tiger.hpp \
           include/whirlpool.hpp \
           include/hashalgorithm.hpp \
           include/qcryptohash.hpp \
    src/libbase58.h

########################### CONFIGURATION ############################
!static {
    DEFINES += QTCRYPTOHASH_EXPORT
}

VER_MAJ = 0
VER_MIN = 1
VER_PAT = 2
VERSION = $${VER_MAJ}.$${VER_MIN}.$${VER_PAT}
