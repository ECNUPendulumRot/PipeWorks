#ifndef CDOWNLOADER_H
#define CDOWNLOADER_H

#include <QUrl>
#include <QFile>
#include <QNetworkReply>
#include <QNetworkAccessManager>

#include <QBasicTimer>
#include <QTimerEvent>
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

    void setFileName(const QString &fileName, int i);

    bool checkConfig();

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

    void sendErrorMsg(QString errorMsg);


private slots:

    void uploadProgress(qint64 bytesSent, qint64 bytesTotal);
    void downloadProgress(qint64 bytesSent, qint64 bytesTotal);

    void downloadFinished();
    void uploadFinished();
    void handleUploadError(QNetworkReply::NetworkError error);
    void handleDownloadError(QNetworkReply::NetworkError error);

private:
    QUrl pUrl;
    QFile file;
    QNetworkAccessManager manager;
    QNetworkReply *pReply;
    QString ip,port,user,password,uploadName,downloadName;
    QByteArray transfromData;
};






class ReplyTimeout : public QObject {
    Q_OBJECT
public:
    enum HandleMethod { Abort, Close };
    ReplyTimeout(QNetworkReply* reply, const int timeout, HandleMethod method = Abort) :
        QObject(reply), m_method(method)
    {
        Q_ASSERT(reply);
        if (reply && reply->isRunning()) {
            m_timer.start(timeout, this);
            connect(reply, &QNetworkReply::finished, this, &QObject::deleteLater);
        }
    }
    static void set(QNetworkReply* reply, const int timeout, HandleMethod method = Abort)
    {
        new ReplyTimeout(reply, timeout, method);
    }
protected:
    QBasicTimer m_timer;
    HandleMethod m_method;
    void timerEvent(QTimerEvent * ev) {
        if (!m_timer.isActive() || ev->timerId() != m_timer.timerId())
            return;
        auto reply = static_cast<QNetworkReply*>(parent());
        if (reply->isRunning())
        {
            if (m_method == Close){
                reply->close();
                qDebug()<<"is closed";
            }
            else if (m_method == Abort)
                reply->abort();
            m_timer.stop();
        }
    }
};
#endif // CDOWNLOADER_H
