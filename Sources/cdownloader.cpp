﻿#include "cdownloader.h"
#include <QCoreApplication>

Downloader::Downloader(QObject *parent)
    : QObject{parent}
{
    pUrl.setScheme("ftp");
}

void Downloader::setHostPort(const QString &host, int port)
{
    pUrl.setHost(host);
    pUrl.setPort(port);
}

void Downloader::setUserInfo(const QString &userName, const QString &password)
{
    pUrl.setUserName(userName);
    pUrl.setPassword(password);
}

void Downloader::put(const QString &fileName, const QString &path)
{
    QFile file(fileName);
    file.open(QIODevice::ReadOnly);
    QByteArray data = file.readAll();
    file.close();

    pUrl.setPath(path);
    qDebug()<<pUrl;

    QNetworkReply *pReply = manager.put(QNetworkRequest(pUrl), data);

    connect(pReply, SIGNAL(uploadProgress(qint64, qint64)), this, SLOT(uploadProgress(qint64, qint64)));
    connect(pReply, SIGNAL(error(QNetworkReply::NetworkError)), this, SIGNAL(error(QNetworkReply::NetworkError)));
    connect(this, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(showError(QNetworkReply::NetworkError)));
}

void Downloader::get(const QString &path, const QString &fileName)
{
    file.setFileName(fileName);
    file.open(QIODevice::WriteOnly | QIODevice::Append);
    pUrl.setPath(path);
    qDebug()<<pUrl;

    QNetworkReply *pReply = manager.get(QNetworkRequest(pUrl));

    connect(pReply, SIGNAL(finished()), this, SLOT(finished()));
    //connect(pReply, SIGNAL(downloadProgress(qint64, qint64)), this, SIGNAL(downloadProgress(qint64, qint64)));
    connect(pReply, SIGNAL(error(QNetworkReply::NetworkError)), this, SIGNAL(error(QNetworkReply::NetworkError)));
    connect(this, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(showError(QNetworkReply::NetworkError)));
}

QString Downloader::toLocal(const QString &path)
{
    QString result = path.mid(8,path.size());
    return result;
}

void Downloader::readConfig()
{
    QFile file(QCoreApplication::applicationDirPath().append("/Database/ftpconfig.config"));
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        return;
    }
    QTextStream in(&file);
    ip = in.readLine();
    port = in.readLine();
    user = in.readLine();
    password = in.readLine();
    uploadName = in.readLine();
}

void Downloader::writeConfig()
{
    QFile file(QCoreApplication::applicationDirPath().append("/Database/ftpconfig.config"));
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)){
        return;
    }
    QTextStream out(&file);
    out << ip << "\n";
    out << port << "\n";
    out << user << "\n";
    out << password << "\n";
    out << uploadName << "\n";
}

QString Downloader::getIP()
{
    return ip;
}
QString Downloader::getPort()
{
    return port;
}
QString Downloader::getUser()
{
    return user;
}
QString Downloader::getPassword()
{
    return password;
}
QString Downloader::getUploadName()
{
    return uploadName;
}
void Downloader::setIP(QString ip)
{
    this->ip = ip;
}
void Downloader::setPort(QString port)
{
    this->port = port;
}
void Downloader::setUser(QString user)
{
    this->user = user;
}
void Downloader::setPassword(QString password)
{
    this->password = password;
}
void Downloader::setUploadName(QString uploadName)
{
    this->uploadName = uploadName;
}

void Downloader::finished()
{

    QNetworkReply *pReply = qobject_cast<QNetworkReply *>(sender());
    switch (pReply->error()) {
    case QNetworkReply::NoError : {
        file.write(pReply->readAll());
        file.flush();
    }
        break;
    default:
        qDebug()<<pReply->errorString();
        break;
    }

    file.close();
    pReply->deleteLater();
}

void Downloader::showError(QNetworkReply::NetworkError error)
{
    switch (error) {
    case QNetworkReply::HostNotFoundError :
        qDebug()<<QString::fromLocal8Bit("主机没有找到");
        break;
        // 其他错误处理
    default:
        qDebug()<<error;
        break;
    }
}

void Downloader::uploadProgress(qint64 bytesSent, qint64 bytesTotal){
    qDebug() << "upload" << bytesSent << "of" << bytesTotal;
    emit upProgress(bytesSent, bytesTotal);
}
