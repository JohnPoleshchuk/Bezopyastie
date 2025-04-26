#include "dbmanager.h"

#include <QSqlError>
#include <QSqlRecord>

    DBManager::DBManager(QObject *parent) : QObject(parent)
{
}

bool DBManager::openDatabase(const QString &path)
{
    m_database = QSqlDatabase::addDatabase("QSQLITE");
    m_database.setDatabaseName(path);

    if (!m_database.open()) {
        qWarning() << "Error opening database:" << m_database.lastError();
        return false;
    }
    return true;
}

QVariantList DBManager::executeQuery(const QString &query)
{
    QVariantList results;
    QSqlQuery sqlQuery(query, m_database);

    if (sqlQuery.lastError().isValid()) {
        qWarning() << "Query error:" << sqlQuery.lastError();
        return results;
    }

    while (sqlQuery.next()) {
        QVariantMap row;

        row["bracle_id"] = sqlQuery.value("bracle_id").toString();
        row["power"] = sqlQuery.value("power").toString();

        results.append(row);
    }

    return results;
}

bool DBManager::executeNonQuery(const QString &query)
{
    QSqlQuery sqlQuery(m_database);
    if (!sqlQuery.exec(query)) {
        qWarning() << "Query error:" << sqlQuery.lastError();
        return false;
    }
    return true;
}

int DBManager::getRowCount(const QString &tableName) {
    QSqlQuery query(m_database);
    query.prepare(QString("SELECT COUNT(*) FROM %1").arg(tableName));

    if (!query.exec() || !query.next()) {
        qWarning() << "Row count failed:" << query.lastError().text();
        return -1;
    }

    return query.value(0).toInt();
}
