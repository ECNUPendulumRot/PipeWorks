#include "partmodel.h"

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
    // FIXME: Implement me!
}

QModelIndex PartModel::parent(const QModelIndex &index) const
{
    // FIXME: Implement me!
}

int PartModel::rowCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    // FIXME: Implement me!
}

int PartModel::columnCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    // FIXME: Implement me!
}

QVariant PartModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    // FIXME: Implement me!
    return QVariant();
}

bool PartModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        // FIXME: Implement me!
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags PartModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
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

    setArray(l);

    return true;
}

void PartModel::setArray(QList<QString> l)
{

}


// these two must call as pair
void PartModel::createArray(unsigned int row, unsigned int col)
{
    if(this->array != nullptr)
        deleteModel();

    this->r = row;
    this->c = col;

    this->array = new QVariant*[row];
    for(unsigned int i = 0; i < row; i++)
        this->array[i] = new QVariant[col];
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

