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

signals:
    void error(QNetworkReply::NetworkError);

    void downloadProgress(qint64 bytesReceived, qint64 bytesTotal);

private slots:

    void uploadProgress(qint64 bytesSent, qint64 bytesTotal);

    void finished();
    void showError(QNetworkReply::NetworkError error);

private:
    QUrl pUrl;
    QFile file;
    QNetworkAccessManager manager;

};

#endif // CDOWNLOADER_H
