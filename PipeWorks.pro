QT       += core gui sql qml quick webchannel quickcontrols2 widgets

CONFIG += qtquickcompiler c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

INCLUDEPATH += ./Headers

SOURCES += \
    Sources/cparamdatabase.cpp \
    Sources/cTmodel.cpp \
    Sources/cscheduler.cpp \
    main.cpp \
    Sources/cmodelmanage.cpp \
    Sources/cuserdb.cpp \
    Sources/cuser.cpp \
    Sources/cdatabase.cpp


HEADERS += \
    Headers/cparamdatabase.h \
    Headers/cuser.h \
    Headers/cTmodel.h \
    Headers/cmodelmanage.h \
    Headers/cdatabase.h \
    Headers/cuserdb.h \
    Headers/cscheduler.h


QML_IMPORT_PATH = QML5/imports

mac {
  Resources.files = Database
  Resources.path = Contents/MacOS
  QMAKE_BUNDLE_DATA += Resources
}

RESOURCES += Resources.qrc\
             $$files(QML5/*) \
             bundle_only.qrc

QTQUICK_COMPILER_SKIPPED_RESOURCES += bundle_only.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    ../../Users/TZZ/OneDrive/桌面/DPlogo.jpg \
    QML5/content/Main/Components/SelectComboBoxFix.qml
