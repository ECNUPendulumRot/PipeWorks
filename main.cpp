﻿#include <QApplication>
#include <QSqlTableModel>
#include <QtWidgets>
#include <QDir>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtWebChannel/QtWebChannel>
#include <QQuickStyle>
#include <QFile>

#include <cscheduler.h>
#include <cparamdatabase.h>
#include <cdownloader.h>
#include <checkmodel.h>


int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("QtExamples");
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication a(argc, argv);
    QQuickStyle::setStyle("Fusion");

    qmlRegisterType<CheckModel>("ModelCraft", 1, 0, "CheckModel");

    QDir dir(QCoreApplication::applicationDirPath().append("/Database"));
    if(!dir.exists())
        dir.mkpath(".");
    qDebug()<<QFile::copy(":/Database/Users.db", QCoreApplication::applicationDirPath().append("/Database/Users.db"));
    qDebug()<<QFile::copy(":/Database/ftpconfig.config", QCoreApplication::applicationDirPath().append("/Database/ftpconfig.config"));

    Scheduler s;

    Downloader d;

    QQmlApplicationEngine engine;

    s.setEngine(&engine);

    engine.addImportPath("qrc:/QML/imports");
    engine.rootContext()->setContextProperty(QStringLiteral("scheduler"), &s);
    engine.rootContext()->setContextProperty(QStringLiteral("downloader"), &d);

//    engine.rootContext()->setContextProperty(QStringLiteral("customModel"), m);
    engine.load(QStringLiteral("qrc:/QML5/content/App.qml"));

    return a.exec();
}
