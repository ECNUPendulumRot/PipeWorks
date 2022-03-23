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
    releaseSelection();
    emit modelDataChanged(QString(""));
    qDebug() << "deleted";
}

//QString TModel::truncate(QList<unsigned int> cl){
//    QString query = "select ";
//    for (int i = 0; i < cl.size(); i++) {
//        QString params;
//        if(parameterCouple[cl[i]].isCouple == true){
//            if(cl[i] == 8)
//                params = "angle, lead" + parameterCouple[cl[i]].name + ", " + "trail" + parameterCouple[cl[i]].name;
//            else
//                params = "angle, " + parameterCouple[cl[i]].name + "_Lead" + ", " + parameterCouple[cl[i]].name + "_Trail";
//        }
//        else
//            params = "angle, " + parameterCouple[cl[i]].name;;
//         query = query + params + (i == cl.size() - 1 ? "":", ");
//    }
//    query = query + " from " + this->tableName() + ";";
//    qDebug() << query;
//    QSqlQueryModel::setQuery(query);

//    //initialize the selection array
//    initializeSelection();

//    emit modelChanged(callWebData());
//    return callWebData();
//}


QHash<int, QByteArray> TModel::roleNames() const
{
    QHash<int, QByteArray> roles = QSqlTableModel::roleNames();
    roles[ColumnRole] = "column";
    roles[RowRole] = "row";
    roles[DirtyRole] = "isDirty";
    roles[SelectionRole] = "isSelect";
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
    case SelectionRole:
        return this->selection[index.row()][index.column()];
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

void TModel::callCrossSelect(unsigned int row, unsigned int col, bool b)
{
    this->selection[row][col] = this->selection[row][col] & b;
    emit dataChanged(this->index(row, col), this->index(row, col), QVector<int>({SelectionRole}));
}

void TModel::callSetSelect(unsigned int row, unsigned int col, bool b)
{
    this->selection[row][col] = b;
    emit dataChanged(this->index(row, col), this->index(row, col), QVector<int>({SelectionRole}));
}

bool TModel::callIsDirty()
{

    return this->isDirty();
}


bool TModel::select()
{
    QSqlTableModel::select();
    initializeSelection();
    return true;
}

//bool TModel::callAddToModel(double v, bool isAdd)
//{
//    for(int i = 0; i < this->rowCount(); i++){
//        for(int j = 1; j < this->columnCount(); j++){
//            if(this->selection[i][j] == true){
//                QVariant oldData = this->data(this->index(i,j));
//                double newData = isAdd? (oldData.toDouble() + v) : (oldData.toDouble() - v);
//                //qDebug() << newData;
//                int round = digitsAfterDecimal(newData);
//                //qDebug() << round;
//                if(round == 0)
//                    this->setData(this->index(i,j), QVariant(int(newData)));
//                else{
//                    double multiplier = std::pow(10.0, round);
//                    this->setData(this->index(i,j), QVariant(std::round(newData * multiplier)/multiplier));
//                }
//            }
//        }
//    }
//    return true;
//}

//bool TModel::setData(const QModelIndex &index, const QVariant &value, int role)
//{
//    QSqlTableModel::setData(index, value, role);
//    qDebug() << "emitted!" ;
//    emit modelSingleDataChanged(index.row(), index.column(), value);
//    return true;
//}


QString TModel::callWebData()
{
    QString s;
    s += QString::number(this->columnCount()) + " ";

    QSqlRecord record = this->record();

    for(int col = 1; col < this->columnCount(); col++){
        s += record.fieldName(col) + " ";
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
    TModel::setData(i, v);
}

QVariant TModel::callGetData(unsigned int i, unsigned int j)
{
    return this->data(this->index(i, j));
}

QString TModel::getChn(QString s)
{
    return engToChn[s];
}

void TModel::initializeSelection()
{
    if(this->selection != nullptr)
        releaseSelection();

    this->selection = new bool*[this->rowCount()];
    for(int i = 0; i < this->rowCount(); i++){
        this->selection[i] = new bool[this->columnCount()];
        for(int j = 0; j < this->columnCount(); j++){
            this->selection[i][j] = false;
        }
    }
}

void TModel::releaseSelection()
{
    if(this->selection == nullptr)
        return;

    for(int i = 0; i < this->rowCount(); i++){
        delete this->selection[i];
        this->selection[i] = nullptr;
    }

    delete this->selection;
    this->selection = nullptr;
}

