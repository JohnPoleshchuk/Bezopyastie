#include <QObject>
#include <QSql>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QVariant>

class DBManager : public QObject
{
    Q_OBJECT
public:
    explicit DBManager(QObject *parent = nullptr);

    Q_INVOKABLE bool openDatabase(const QString &path);
    Q_INVOKABLE QVariantList executeQuery(const QString &query);
    Q_INVOKABLE bool executeNonQuery(const QString &query);
    Q_INVOKABLE int getRowCount(const QString &tableName);

private:
    QSqlDatabase m_database;
};
