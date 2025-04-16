QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    errorwindow.cpp \
    functions.cpp \
    main.cpp \
    mainwindow.cpp \
    radioitem.cpp \
    searchdatedialog.cpp \
    searchdialog.cpp \
    sortdialog.cpp

HEADERS += \
    errorwindow.h \
    functions.h \
    mainwindow.h \
    radioitem.h \
    searchdatedialog.h \
    searchdialog.h \
    sortdialog.h

FORMS += \
    errorwindow.ui \
    mainwindow.ui \
    searchdatedialog.ui \
    searchdialog.ui \
    sortdialog.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
