#include <cTmodel.h>
#include <QLatin1String>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QDebug>

TModel::TModel():QSqlTableModel()//truncate model,used to choose specific data from table
{

}

TModel::TModel(QSqlDatabase &db):QSqlTableModel(nullptr, db)//truncate model,used to choose specific data from table
{
}

TModel::~TModel()
{
    emit modelDataChanged(QString(""));
    qDebug() << "deleted";
}

QString TModel::truncate(QList<unsigned int> cl){
    QString query = "select ";
    for (int i = 0; i < cl.size(); i++) {
        QString params;
        if(parameterCouple[cl[i]].isCouple == true){
            if(cl[i] == 8)
                params = "angle, lead" + parameterCouple[cl[i]].name + ", " + "trail" + parameterCouple[cl[i]].name;
            else
                params = "angle, " + parameterCouple[cl[i]].name + "_Lead" + ", " + parameterCouple[cl[i]].name + "_Trail";
        }
        else
            params = "angle, " + parameterCouple[cl[i]].name;;
         query = query + params + (i == cl.size() - 1 ? "":", ");
    }
    query = query + " from " + this->tableName() + ";";
    QSqlQueryModel::setQuery(query);
    emit modelChanged(callWebData());
    return callWebData();
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
    emit modelDataChanged(callWebData());
}

void TModel::callRevert()
{
    this->revertAll();
    emit modelDataChanged(callWebData());
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


QString TModel::callWebData()
{
    QString s;
    s += QString::number(this->columnCount()) + " ";

    QSqlRecord record = this->record();

    for(int col = 1; col < this->columnCount(); col++){
        s += getChn(record.fieldName(col)) + " ";
    }
    if(this->columnCount() < 3)
        s += "null ";

    for(int col = 1; col < this->columnCount(); col++){
        for(int row = 0; row < this->rowCount(); row ++){
            QModelIndex i = this->index(row, col, QModelIndex());
            s += QString::number(this->data(i).toDouble()) + " ";
        }
    }
    return s;
}


QVariant TModel::fixedTablePopData(unsigned int i, QString s)
{
    return this->record(i).value(s);
}

void TModel::callSetData(unsigned int row, unsigned int col, QVariant v)
{
    QModelIndex i = this->index(row, col, QModelIndex());
    this->setData(i, v);
}

QString TModel::getChn(QString s)
{
    return engToChn[s];
}
