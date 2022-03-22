#include "partmodel.h"
#include <QSqlRecord>
#include <utility.h>

PartModel::PartModel(QObject *parent)
    : QAbstractItemModel(parent)
{
    this->array = nullptr;
    this->r = 0;
    this->c = 0;
}


bool PartModel::setHeaderData(int section, Qt::Orientation orientation, const QVariant &value, int role)
{
    if (value != headerData(section, orientation, role)) {
        // FIXME: Implement me!
        emit headerDataChanged(orientation, section, section);
        return true;
    }
    return false;
}

QModelIndex PartModel::index(int row, int column, const QModelIndex &parent) const
{
    return this->createIndex(row, column);
}


//QModelIndex PartModel::parent(const QModelIndex &index) const
//{
//    // FIXME: Implement me!
//}


int PartModel::rowCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    // customize:
    return this->r;
}

int PartModel::columnCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    // customize:
    return this->c;
}


QHash<int, QByteArray> PartModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[RowRole] = "row";
    roles[ColumnRole] = "column";
    roles[DirtyRole] = "isDirty";
    roles[ChangeRole] = "isChanged";
    roles[SelectionRole] = "isSelect";

    // pair role for edit and display
    roles[Qt::DisplayRole] = "display";
    roles[Qt::EditRole] = "display";
    return roles;
}


QVariant PartModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    switch(role){
    case ColumnRole:
        return index.column();
    case RowRole:
        return index.row();
    case ChangeRole:
        return this->connectedTable->data(this->connectedTable->index(index.row(),index.column())) ==
                this->array[index.row()][index.column()].v;
    case DirtyRole:
        return this->connectedTable->isDirty(this->connectedTable->index(index.row(),index.column()));
    case SelectionRole:
        return this->selection[index.row()][index.column()];
    case Qt::DisplayRole:
        return this->array[index.row()][index.column()].v;
    }
    // FIXME: Implement me!
    return QVariant();
}

bool PartModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        switch(role){
        // self related role
        case Qt::EditRole:
            this->array[index.row()][index.column()].v = value;
            emit dataChanged(index, index, QVector<int>({Qt::DisplayRole, ChangeRole}));
            emit partDataChanged(index.row(), index.column(), value);
            return true;
        case SelectionRole:
            if(this->flags(index) == (Qt::ItemIsEditable | Qt::ItemIsSelectable | Qt::ItemIsEnabled)){
                this->selection[index.row()][index.column()] = value.toBool();
                emit dataChanged(index, index, QVector<int>({SelectionRole}));
                emit partSelectChanged(index.row(), index.column(), value.toBool());
            }
            return true;
        }
        //emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags PartModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    if(index.column() != 0)
        return Qt::ItemIsEditable | Qt::ItemIsSelectable | Qt::ItemIsEnabled;
    else return Qt::NoItemFlags;

}

// array related operation
bool PartModel::changeSelectIndex(int index)
{
    if(index >= parameterCouple.size())
        return false;

    QList<QString> l;
    l.push_back("angle");
    if(parameterCouple[index].isCouple){
        l.push_back((index == 8 ? "lead"  : "") + parameterCouple[index].name + (index == 8 ? ""  : "_Lead"));
        l.push_back((index == 8 ? "trail" : "") + parameterCouple[index].name + (index == 8 ? "l" : "_Trail"));
    }
    else
        l.push_back(parameterCouple[index].name);

    pullArray(l);

    return true;
}

bool PartModel::changeBackendTable(TModel *newConnectedTable)
{
    deleteArray();
    setConnectedTable(newConnectedTable);
    return true;
}

bool PartModel::pullArray(QList<QString> l)
// Pop data by header name list L and push them into array
{
    if(this->array == nullptr || this->connectedTable == nullptr)
        return false;

    // body

    createArray(connectedTable->rowCount(), l.size());

    for(int i = 0; i < connectedTable->rowCount(); i++){
        QSqlRecord r = connectedTable->record(i);
        int j = 0;
        for(int k = 0; k < r.count(); k++){
            if(r.fieldName(k) == l[j]){
                this->array[i][j] = MapData(i, k, r.value(k));
                j++;
            }
        }
    }
    emit this->dataReady();
    // body
    return true;
}

bool PartModel::pushArray()
{
    if(this->connectedTable == nullptr || this->array == nullptr)
        return false;

    for(unsigned int i = 0; i < this->r; i++){
        for(unsigned int j = 0; j < this->c; j++){
            if(this->data(this->index(i, j), ChangeRole).toBool())
                this->connectedTable->setData(
                        this->connectedTable->index(this->array[i][j].map_r,this->array[i][j].map_c),
                        this->array[i][j].v);
         }
    }
    return true;
}

// array create and destroy
// these two must call as pair
void PartModel::createArray(unsigned int row, unsigned int col)
{
    if(this->array != nullptr)
        deleteArray();

    this->r = row;
    this->c = col;

    this->array = new MapData*[row];
    for(unsigned int i = 0; i < row; i++)
        this->array[i] = new MapData[col];
}


void PartModel::deleteArray()
{
    if(this->array == nullptr)
        return;

    for(unsigned int i = 0; i < this->r; i++){
        delete  this->array[i];
    }
    delete this->array;
    this->r = 0;
    this->c = 0;
}


// model getter and setter
TModel *PartModel::getConnectedTable() const
{
    return connectedTable;
}

void PartModel::setConnectedTable(TModel *newConnectedTable)
{
    connectedTable = newConnectedTable;
}


// selection related function
bool TModel::callAddToModel(double v, bool isAdd)
{
    for(int i = 0; i < this->rowCount(); i++){
        for(int j = 1; j < this->columnCount(); j++){
            if(this->selection[i][j] == true){
                QVariant oldData = this->data(this->index(i,j));
                double newData = isAdd? (oldData.toDouble() + v) : (oldData.toDouble() - v);
                //qDebug() << newData;
                int round = digitsAfterDecimal(newData);
                //qDebug() << round;
                if(round == 0)
                    this->setData(this->index(i,j), QVariant(int(newData)));
                else{
                    double multiplier = std::pow(10.0, round);
                    this->setData(this->index(i,j), QVariant(std::round(newData * multiplier)/multiplier));
                }
            }
        }
    }
    return true;
}


void PartModel::callCrossSelect(unsigned int row, unsigned int col, bool b)
{
    this->selection[row][col] = this->selection[row][col] & b;
    emit dataChanged(this->index(row, col), this->index(row, col), QVector<int>({SelectionRole}));
}

void PartModel::callSetSelect(unsigned int row, unsigned int col, bool b)
{
    this->selection[row][col] = b;
    emit dataChanged(this->index(row, col), this->index(row, col), QVector<int>({SelectionRole}));
}


void PartModel::initializeSelection()
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


void PartModel::releaseSelection()
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
