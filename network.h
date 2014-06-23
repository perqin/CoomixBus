#ifndef NETWORK_H
#define NETWORK_H

#include <QObject>
#include <QDeclarativeListProperty>
#include <QList>
#include <QtNetwork>
#include <QStringList>

class Network : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString data READ getData WRITE setData NOTIFY sendDataChange)
    Q_PROPERTY(QString reqUrl READ getReqUrl WRITE setReqUrl NOTIFY sendReqUrlChange)
    Q_PROPERTY(QString reqType READ getReqType WRITE setReqType NOTIFY sendReqTypeChange)
    Q_PROPERTY(QString citycode READ getCitycode WRITE setCitycode NOTIFY sendCitycodeChange)

public:
    explicit Network(QObject *parent = 0);
    QString getData() const;
    Q_INVOKABLE void setData(const QString& p_data);
    QString getReqUrl() const;
    Q_INVOKABLE void setReqUrl(const QString& p_reqUrl);
    QString getReqType() const;
    Q_INVOKABLE void setReqType(const QString& p_reqType);
    QString getCitycode() const;
    Q_INVOKABLE void setCitycode(const QString& p_citycode);
    Q_INVOKABLE QVariant getDataObj(const QString& p_type) const;

public slots:
    void retrieveData();
    void handleNetworkData(QNetworkReply *networkReply);

signals:
    void sendDataChange();
    void sendReqUrlChange();
    void sendReqTypeChange();
    void sendCitycodeChange();

private:
    QNetworkAccessManager networkManager;
    QString m_Data;
    QString m_ReqUrl;
    QString m_ReqType;
    QString m_Citycode;
    QStringList m_AllLines;

};

#endif // NETWORK_H
