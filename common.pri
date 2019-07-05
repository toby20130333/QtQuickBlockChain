# Uncomment the following line to compile QtCrypotHash as static library!
# CONFIG += static

contains(QT_ARCH, i386) {
    PLATFORM = x86
} else {
    PLATFORM = x64
        ARCH_SUFFIX = 64
}

CONFIG(debug, debug|release) {
    BUILD = debug
} else {
    BUILD = release
}

static {
    DEFINES += QTCRYPTOHASH_STATIC
    DESTDIR  = $$PWD/bin/$${PLATFORM}/static/$${BUILD}
} else {
    DESTDIR  = $$PWD/bin/$${PLATFORM}/dynamic/$${BUILD}
}

win32:{
    #RC_FILE += tfupdate.rc

    CONFIG += skip_target_version_ext
    RC_LANG = 2052
    QMAKE_TARGET_COMPANY ="https://www.heilqt.com"
    QMAKE_TARGET_COPYRIGHT ="Copyright 2018~2022 Shanghai DDui Inc. All Rights Reserved"
    QMAKE_TARGET_DESCRIPTION ="DDN区块链浏览器"
    QMAKE_TARGET_PRODUCT = "多多指教-出品"

    VERSION = 0.0.0.1
    #message(local version is:$$VERSION)
    QMAKE_LFLAGS_RELEASE += /MAP
    QMAKE_CFLAGS_RELEASE += /Zi
    QMAKE_LFLAGS_RELEASE += /debug /opt:ref
}
