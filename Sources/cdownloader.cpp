#include "cdownloader.h"
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
    transfromData = file.readAll();
    file.close();

    pUrl.setPath(path);
    pReply = manager.put(QNetworkRequest(pUrl), transfromData);
    ReplyTimeout::set(pReply, 1000);//reply time out
    connect(pReply, SIGNAL(uploadProgress(qint64, qint64)), this, SLOT(uploadProgress(qint64, qint64)));
    connect(pReply, SIGNAL(errorOccurred(QNetworkReply::NetworkError)), this, SLOT(handleUploadError(QNetworkReply::NetworkError)));
    connect(pReply, SIGNAL(finished()), this, SLOT(uploadFinished()));
}

void Downloader::get(const QString &path, const QString &fileName)
{
    setFileName(fileName, 1);
    pUrl.setPath(path);
    pReply = manager.get(QNetworkRequest(pUrl));
    ReplyTimeout::set(pReply, 1000);//reply time out
    connect(pReply, SIGNAL(finished()), this, SLOT(downloadFinished()));
    connect(pReply, SIGNAL(downloadProgress(qint64, qint64)), this, SLOT(downloadProgress(qint64, qint64)));
    connect(pReply, SIGNAL(errorOccurred(QNetworkReply::NetworkError)), this, SLOT(handleDownloadError(QNetworkReply::NetworkError)));
}

void Downloader::setFileName(const QString &fileName, int i)
{
    QString tempName = fileName;
    file.setFileName(tempName);
    if(!file.exists()){
        qDebug()<<"start to download";
        file.open(QIODevice::WriteOnly | QIODevice::Append);
    }
    else{
        QString label = "(" + QString::number(i) + ")";
        tempName = tempName.mid(0,tempName.lastIndexOf(".")) +label+tempName.mid(tempName.lastIndexOf("."),tempName.size());
        setFileName(tempName, i+1);
    }
}

bool Downloader::checkConfig()
{
    if(ip == "" || port =="" || user == "" || password == "" || uploadName== "" || downloadName ==""){
        return false;
    }
    else return true;
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
    downloadName = in.readLine();
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
    out << downloadName << "\n";
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
QString Downloader::getDownloadName()
{
    return downloadName;
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

void Downloader::setDownloadName(QString downloadName)
{
    this->uploadName = downloadName;
}

void Downloader::downloadFinished()
{

    //QNetworkReply *pReply = qobject_cast<QNetworkReply *>(sender());
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
    qDebug()<<"finished"<<pReply->isFinished();
    pReply->deleteLater();
}

void Downloader::uploadFinished()
{
    switch (pReply->error()) {
    case QNetworkReply::NoError : {
        pReply->deleteLater();
        qDebug()<<"finished"<<pReply->isFinished();
    }
        break;
    default:
        qDebug()<<pReply->errorString();
        break;
    }
    transfromData.clear();
    qDebug()<<pUrl.host()<<"finished"<<pReply->isFinished();
    pReply->deleteLater();
}

void Downloader::handleUploadError(QNetworkReply::NetworkError error)
{
    switch (error) {
    case QNetworkReply::OperationCanceledError :
        qDebug()<<QString::fromLocal8Bit("IP or port error ");
        emit sendErrorMsg("IP or port error , please check your ftp setting");
        break;
    case QNetworkReply::AuthenticationRequiredError :
        qDebug()<<QString::fromLocal8Bit("FTP账号密码错误");
        emit sendErrorMsg("ID or passoword error ");
        break;
        // 其他错误处理
    default:
        qDebug()<<"error:";
        qDebug()<<error;
        emit sendErrorMsg("there are someting error occured");
        break;
    }
}

void Downloader::handleDownloadError(QNetworkReply::NetworkError error)
{
    switch (error) {
    case QNetworkReply::OperationCanceledError :
        qDebug()<<QString::fromLocal8Bit("IP or port error ");
        emit sendErrorMsg("IP or port error , please check your ftp setting");
        break;
    case QNetworkReply::AuthenticationRequiredError :
        qDebug()<<QString::fromLocal8Bit("FTP账号密码错误");
        emit sendErrorMsg("ID or passoword error  ");
        break;
    case QNetworkReply::ContentNotFoundError :
        qDebug()<<QString::fromLocal8Bit("要下载的文件不存在");
        emit sendErrorMsg("file not found");
        break;
        // 其他错误处理ContentNotFoundError
    default:
        qDebug()<<"error:";
        qDebug()<<error;
        emit sendErrorMsg("there are someting error occured");
        break;
    }
}

void Downloader::uploadProgress(qint64 bytesSent, qint64 bytesTotal){
    qDebug() << "upload" << bytesSent << "of" << bytesTotal;
    emit upProgress(bytesSent, bytesTotal);
}

void Downloader::downloadProgress(qint64 bytesSent, qint64 bytesTotal)
{
    qDebug() << "download" << bytesSent << "of" << bytesTotal;
    emit downProgress(bytesSent, bytesTotal);
}
