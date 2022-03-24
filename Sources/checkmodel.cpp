#include "checkmodel.h"

CheckModel::CheckModel(QObject *parent)
    : QAbstractTableModel(parent)
{
}


int CheckModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    // FIXME: Implement me!
    return this->list.size();
}


int CheckModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    // FIXME: Implement me!
    return 1;
}


QVariant CheckModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    switch(role){
    case CheckRole:
        return this->list[index.row()];
    }

    // FIXME: Implement me!
    return QVariant();
}


bool CheckModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        // FIXME: Implement me!
        switch(role){
        case CheckRole:
            list[index.row()] = value.toBool();
            emit checkChanged(index.row(), list[index.row()]);
            emit dataChanged(index, index, QVector<int>() << role);
        }
        return true;
    }
    return false;
}


Qt::ItemFlags CheckModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}


QHash<int, QByteArray> CheckModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[CheckRole] = "check";
    return roles;
}


void CheckModel::append(bool b)
{
    beginInsertRows(QModelIndex(), this->list.size(), this->list.size());

    this->list.append(b);

    endInsertRows();
}


void CheckModel::clear()
{
    beginResetModel();

    this->list.clear();

    endResetModel();
}


void CheckModel::reset()
{
    this->set(false);
}


void CheckModel::set(bool b)
{
    for( int i = 0; i < this->list.size(); i++){
        this->setData(this->index(i, 0), b, CheckRole);
    }
}


bool CheckModel::at(int i)
{
    return this->list[i];
}
