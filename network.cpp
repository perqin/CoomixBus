#include "network.h"
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlRecord>
#include <QtSql/QSqlField>

Network::Network(QObject *parent) :
    QObject(parent), m_Data("u"), m_ReqUrl("u"), m_ReqType("get")
{
    connect(&networkManager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(handleNetworkData(QNetworkReply*)));
}

void Network::retrieveData()
{
    qDebug() << "Retrieve start!";
    QUrl url(m_ReqUrl);
    qDebug() << url;
    networkManager.get(QNetworkRequest(url));
    qDebug() << "Retrieve stop!";
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

void Network::handleNetworkData(QNetworkReply *networkReply)
{
    qDebug() << "Handle start!";
    if(!networkReply->error()){
        qDebug() << "data = " << m_Data;
        //setData(networkReply->readAll());
        //======Sql
        QSqlDatabase db_db = QSqlDatabase::addDatabase("QSQLITE");
        db_db.setDatabaseName("json.db");
        if(!db_db.open()){
            qDebug() << "Error opening db_db";
        }else{
            qDebug() << "Succeed in opening db_db";
        }
        QSqlQuery db_query(db_db);
        bool db_ok = db_query.exec("create table person (id int primary key, firstname varchar(20), lastname varchar(20))");
        db_query.exec("insert into person values(101, 'Danny', 'Young')");
        db_query.exec("insert into person values(102, 'Christine', 'Holand')");
        if(!db_ok){
            qDebug() << "table is error";
        }else{
            qDebug() << "table is ok";
        }
        //query.exec("INSERT INTO persons VALUES ('xue','chao','langfang')");
        //db.close();
        //======Sql_end
        qDebug() << getData();
        qDebug() << "Get succeed!";
        qDebug() << "data = " << m_Data;
    }else{
        qDebug() << "Get failed!";
        qDebug() << networkReply->errorString();
    }
    networkReply->deleteLater();
}
