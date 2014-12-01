#include "network.h"
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlRecord>
#include <QtSql/QSqlField>
#include <QByteArray>
//#include <QStringList>

Network::Network(QObject *parent) :
    QObject(parent), m_Data("u"), m_ReqUrl("u"), m_ReqType("get"), m_Citycode("0")
{
    connect(&networkManager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(handleNetworkData(QNetworkReply*)));
}

void Network::retrieveData()
{
    QUrl url(m_ReqUrl);
    /*if(m_ReqType == "sest") {
        url = "http://busapi.gpsoo.net/v1/bus/mbcommonservice?method=getmatchedstations&citycode=860515&mapType=G_NORMAL_MAP&cn=gm";
        url.addQueryItem("stationname", "深圳");
    }*/
    qDebug() << "DEBUG_FROM_C++#" << url;
    networkManager.get(QNetworkRequest(url));
}

QString Network::getData() const
{
    return m_Data;
}

void Network::setData(const QString &p_data)
{
    m_Data = p_data;
    qDebug() << m_Data;
    emit sendDataChange();
}

QString Network::getReqType() const
{
    return m_ReqType;
}

void Network::setReqType(const QString &p_reqType)
{
    m_ReqType = p_reqType;
    qDebug() << m_ReqType;
    emit sendReqTypeChange();
}

QString Network::getReqUrl() const
{
    return m_ReqUrl;
}

void Network::setReqUrl(const QString &p_reqUrl)
{
    m_ReqUrl = p_reqUrl;
    qDebug() << m_ReqUrl;
    emit sendReqUrlChange();
}

QString Network::getCitycode() const
{
    return m_Citycode;
}

void Network::setCitycode(const QString &p_citycode)
{
    m_Citycode = p_citycode;
    qDebug() << m_Citycode;
    emit sendCitycodeChange();
}

QVariant Network::getDataObj(const QString &p_type) const
{
    if(p_type == "all"){
        return m_AllLines;
    }
}

void Network::handleNetworkData(QNetworkReply *networkReply)
{
    if(!networkReply->error()){
        QByteArray data_qba("");
        data_qba = networkReply->readAll();
        if(m_ReqType=="all"){
            qDebug() << "TYPE:ALL";
            int i = 0;
            while(data_qba.mid(i, 7) != "success"){i++;}
            i += 10;
            if(data_qba.at(i) == 't'){
                QByteArray tem("");
                int l, pl;
                m_AllLines.clear();
                while(data_qba.at(i) != '['){i++;}
                for(l = i; data_qba.at(l) != ']'; l++){
                    if(data_qba.at(l) == '{'){ pl = l; }
                    if(data_qba.at(l) == '}'){
                        tem = data_qba.mid(pl, l - pl + 1);
                        int k = 0;
                        while (tem.mid(k, 6) != "isopen") { ++k; }
                        if (tem.at(k + 9) == '1')
                        {
                            qDebug() << tem;
                            m_AllLines.append(tem);
                        }
                    }
                }
                setData("all");
            }else{
                qDebug() << "Data Error!";
            }
        }else{
            qDebug() << "TYPE:NOT ALL";
            setData(data_qba);
            qDebug() << "data-------" << getData();
        }
    }else{
        qDebug() << "Get failed : " << networkReply->errorString();
    }
    networkReply->deleteLater();
}
