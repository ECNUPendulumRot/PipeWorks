#include <cTmodel.h>
#include <QLatin1String>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QDebug>
//#include <utility.h>

TModel::TModel():QSqlTableModel()//truncate model,used to choose specific data from table
{

}


TModel::TModel(QSqlDatabase &db):QSqlTableModel(nullptr, db)//truncate model,used to choose specific data from table
{
}


TModel::~TModel()
{
    emit modelDataChanged(QString(""));
}


QHash<int, QByteArray> TModel::roleNames() const
{
    QHash<int, QByteArray> roles = QSqlTableModel::roleNames();
    roles[ColumnRole] = "column";
    roles[RowRole] = "row";
    roles[DirtyRole] = "isDirty";
    return roles;
}


QVariant TModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    // FIXME: Implement me!
    switch(role){
    case ColumnRole:
        return index.column();
    case RowRole:
        return index.row();
    case DirtyRole:
        return this->isDirty(index);
    default:
        return QSqlTableModel::data(index, role);
    }

    return QVariant();
}


QString TModel::headerNameEng(unsigned int i)
{
    return this->record().fieldName(i);
}


void TModel::callSubmit()
{
    this->submitAll();
    emit refreshDirty();
}


void TModel::callRevert()
{
    this->revertAll();
    emit refreshDirty();
}


bool TModel::callIsDirty(unsigned int row, unsigned int col)
{
    QModelIndex i = this->index(row, col, QModelIndex());
    return this->isDirty(i);
}

bool TModel::callIsDirty()
{

    return this->isDirty();
}

QVector<QString>* TModel::getTableQuery()
{
    QVector<QString>* query = new QVector<QString>();
    QString tableName = this->tableName();

    for(int i = 0; i < this->rowCount(); i++){
        QString upDate = "UPDATE " + tableName + " ";
        upDate += rowQuery(i);
        query->push_back(upDate);
    }

    return query;
}

QString TModel::getRowQuery(int index)
{
    return rowQuery(index);
}

QString TModel::rowQuery(int index)
{
    QSqlRecord record = this->record(index);

    QString result = "SET ";

    for(int i = 1; i < record.count() - 1; i++){
        QString tmp = record.fieldName(i) + " = " + (record.fieldName(i) == "showName"? "'" + record.value(i).toString() + "'":record.value(i).toString())
                                          + (i == record.count() - 1 ? "": ",");
        result += tmp;
    }
    result += " WHERE " + record.fieldName(0)
                        + " = " + (record.fieldName(0) == "passName"? "'" + record.value(0).toString() + "'":record.value(0).toString()) + ";";
    return result;
}


QVariant TModel::fixedTablePopData(unsigned int i, QString s)
{
    return this->record(i).value(s);
}


void TModel::callSetData(unsigned int row, unsigned int col, QVariant v)
{
    QModelIndex i = this->index(row, col, QModelIndex());
    TModel::setData(i, v);
}


QVariant TModel::callGetData(unsigned int i, unsigned int j)
{
    return this->data(this->index(i, j));
}





