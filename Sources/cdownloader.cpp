#include "cdownloader.h"
#include <QCoreApplication>
Downloader::Downloader(QObject *parent)
    : QObject{parent}
{
    pUrl.setScheme("ftp");
    //manager.setTransferTimeout(1000);
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

void Downloader::put(const QString &fileName, const QString &path, QString method)
{
    QFile file(fileName);
    file.open(QIODevice::ReadOnly);
    QByteArray transfromData = file.readAll();
    file.close();

    pUrl.setPath(path);
    pReply = manager.put(QNetworkRequest(pUrl), transfromData);
    ReplyTimeout::set(pReply, 1000);//reply time out    
    if(method == "default"){
        connect(pReply, SIGNAL(uploadProgress(qint64, qint64)), this, SLOT(uploadProgress(qint64, qint64)));
        connect(pReply, SIGNAL(errorOccurred(QNetworkReply::NetworkError)), this, SLOT(handleUploadError(QNetworkReply::NetworkError)));
        connect(pReply, SIGNAL(finished()), this, SLOT(uploadFinished()));
    }
    if(method == "singleTable"){
        //connect(pReply, SIGNAL(uploadProgress(qint64, qint64)), this, SLOT(uploadProgress(qint64, qint64)));
        connect(pReply, SIGNAL(errorOccurred(QNetworkReply::NetworkError)), this, SLOT(handleUploadError(QNetworkReply::NetworkError)));
        connect(pReply, SIGNAL(finished()), this, SLOT(singleTable3Finished()));//ST = single table
    }
}

void Downloader::get(const QString &path, const QString &fileName, QString method)
{

    file.setFileName(fileName);

    pUrl.setPath(path);
    pReply = manager.get(QNetworkRequest(pUrl));
    ReplyTimeout::set(pReply, 1000);//reply time out
    //connect(pReply, SIGNAL(finished()), this, SLOT(downloadFinished()));
    if(method == "default"){
        connect(pReply, SIGNAL(downloadProgress(qint64, qint64)), this, SLOT(downloadProgress(qint64, qint64)));
        connect(pReply, SIGNAL(errorOccurred(QNetworkReply::NetworkError)), this, SLOT(handleDownloadError(QNetworkReply::NetworkError)));
        connect(pReply, SIGNAL(finished()), this, SLOT(downloadFinished()));
    }
    if(method == "singleTable"){
        connect(pReply, SIGNAL(finished()), this, SLOT(singleTable1Finished()));
        connect(pReply, SIGNAL(errorOccurred(QNetworkReply::NetworkError)), this, SLOT(handleDownloadError(QNetworkReply::NetworkError)));
       // connect(pReply, SIGNAL(downloadProgress(qint64, qint64)), this, SLOT(downloadProgress(qint64, qint64)));
    }
}

bool Downloader::checkIfExist(const QString &fileName)
{
    file.setFileName(fileName);
    if(file.exists())
        return true;
    else
        return false;
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
    this->downloadName = downloadName;
}



void Downloader::downloadFinished()
{

    //QNetworkReply *pReply = qobject_cast<QNetworkReply *>(sender());
    switch (pReply->error()) {
    case QNetworkReply::NoError :
        file.remove();
        file.open(QIODevice::WriteOnly | QIODevice::Append);
        file.write(pReply->readAll());
        file.flush();
        break;
    default:
        qDebug()<<pReply->errorString();
        break;
    }
    file.close();
    qDebug()<<"finished"<<pReply->isFinished();
    pReply->deleteLater();
    manager.clearAccessCache();
}

void Downloader::singleTable1Finished()
{
    //QNetworkReply *pReply = qobject_cast<QNetworkReply *>(sender());
    switch (pReply->error()) {
    case QNetworkReply::NoError :
        file.remove();
        file.open(QIODevice::WriteOnly | QIODevice::Append);
        file.write(pReply->readAll());
        file.flush();
        file.close();
        pReply->deleteLater();
        manager.clearAccessCache();
        emit startSingleTableStep2and3();//只有正确下载了才会上传数据
        break;
    default:
        qDebug()<<pReply->errorString();
        file.flush();
        file.close();
        pReply->deleteLater();
        manager.clearAccessCache();
        break;
    }



}

void Downloader::singleTable3Finished()
{
    switch (pReply->error()) {
    case QNetworkReply::NoError : {

        qDebug()<<"finished"<<pReply->isFinished();
        emit singleTableAllFinished();
    }
        break;
    default:
        qDebug()<<pReply->errorString();
        break;
    }
    pReply->deleteLater();
    manager.clearAccessCache();
}

void Downloader::uploadFinished()
{
    switch (pReply->error()) {
    case QNetworkReply::NoError :
        qDebug()<<"finished"<<pReply->isFinished();
        break;
    default:
        qDebug()<<pReply->errorString();
        break;
    }
    pReply->deleteLater();
    manager.clearAccessCache();
}

void Downloader::handleUploadError(QNetworkReply::NetworkError error)
{
    switch (error) {
    case QNetworkReply::OperationCanceledError :
        qDebug()<<QString::fromLocal8Bit("IP or port error ");
        emit sendErrorMsg("OperationCanceledError");
        break;
    case QNetworkReply::AuthenticationRequiredError :
        qDebug()<<QString::fromLocal8Bit("FTP账号密码错误");
        emit sendErrorMsg("AuthenticationRequiredError");
        break;
        // 其他错误处理
    default:
        qDebug()<<"error:";
        qDebug()<<error;
        emit sendErrorMsg("error");
        break;
    }
}

void Downloader::handleDownloadError(QNetworkReply::NetworkError error)
{
    switch (error) {
    case QNetworkReply::OperationCanceledError :
        qDebug()<<QString::fromLocal8Bit("IP or port error ");
        emit sendErrorMsg("OperationCanceledError");
        break;
    case QNetworkReply::AuthenticationRequiredError :
        qDebug()<<QString::fromLocal8Bit("FTP账号密码错误");
        emit sendErrorMsg("AuthenticationRequiredError");
        break;
    case QNetworkReply::ContentNotFoundError :
        qDebug()<<QString::fromLocal8Bit("要下载的文件不存在");
        emit sendErrorMsg("ContentNotFoundError");
        break;
        // 其他错误处理ContentNotFoundError
    default:
        qDebug()<<"Download error:";
        qDebug()<<error;
        emit sendErrorMsg("error");
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
