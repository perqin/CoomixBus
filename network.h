#ifndef NETWORK_H
#define NETWORK_H

#include <QObject>
#include <QDeclarativeListProperty>
#include <QList>
#include <QtNetwork>

class Network : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString data READ getData WRITE setData NOTIFY sendDataChange)
    Q_PROPERTY(QString reqUrl READ getReqUrl WRITE setReqUrl NOTIFY sendReqUrlChange)
    Q_PROPERTY(QString reqType READ getReqType WRITE setReqType NOTIFY sendReqTypeChange)

public:
    explicit Network(QObject *parent = 0);
    QString getData() const;
    Q_INVOKABLE void setData(const QString& p_data);
    QString getReqUrl() const;
    Q_INVOKABLE void setReqUrl(const QString& p_reqUrl);
    QString getReqType() const;
    Q_INVOKABLE void setReqType(const QString& p_reqType);

public slots:
    void retrieveData();
    void handleNetworkData(QNetworkReply *networkReply);

signals:
    void sendDataChange();
    void sendReqUrlChange();
    void sendReqTypeChange();

private:
    QNetworkAccessManager networkManager;
    QString m_Data;
    QString m_ReqUrl;
    QString m_ReqType;

};

#endif // NETWORK_H
