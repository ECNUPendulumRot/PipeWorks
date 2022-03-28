#ifndef CDOWNLOADER_H
#define CDOWNLOADER_H

#include <QUrl>
#include <QFile>
#include <QNetworkReply>
#include <QNetworkAccessManager>

class Downloader : public QObject
{
    Q_OBJECT
public:
    explicit Downloader(QObject *parent = nullptr);

public slots:

    void setHostPort(const QString &host, int port = 21);

    void setUserInfo(const QString &userName, const QString &password);

    void put(const QString &fileName, const QString &path);

    void get(const QString &path, const QString &fileName);

    QString toLocal(const QString &path);

    void readConfig();
    void writeConfig();

    QString getIP();
    QString getPort();
    QString getUser();
    QString getPassword();
    QString getUploadName();
    QString getDownloadName();
    void setIP(QString ip);
    void setPort(QString port);
    void setUser(QString user);
    void setPassword(QString password);
    void setUploadName(QString uploadName);
    void setDownloadName(QString downloadName);
signals:

    void error(QNetworkReply::NetworkError);

    void upProgress(qint64 bytesSent, qint64 bytesTotal);

    void downProgress(qint64 bytesSent, qint64 bytesTotal);

private slots:

    void uploadProgress(qint64 bytesSent, qint64 bytesTotal);
    void downloadProgress(qint64 bytesSent, qint64 bytesTotal);

    void finished();
    void showError(QNetworkReply::NetworkError error);

private:
    QUrl pUrl;
    QFile file;
    QNetworkAccessManager manager;
    QString ip,port,user,password,uploadName,downloadName;
};

#endif // CDOWNLOADER_H
