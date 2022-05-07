#include <partmodel.h>
#include <QSqlRecord>
#include <utility.h>

PartModel::PartModel(QObject *parent)
    : QAbstractItemModel(parent)
{
    this->array = nullptr;
    this->r = 0;
    this->c = 0;
    this->header.clear();
}

QModelIndex PartModel::index(int row, int column, const QModelIndex &parent) const
{
    if(row < 0 || row >= (int)r || column < 0 || column > (int)c)
        return QModelIndex();
    return this->createIndex(row, column);
}


QModelIndex PartModel::parent(const QModelIndex &index) const
{
    // FIXME: Implement me!
    return QModelIndex();
}


int PartModel::rowCount(const QModelIndex &parent) const
{
    return this->r;
}

int PartModel::columnCount(const QModelIndex &parent) const
{
    return this->c;
}


QHash<int, QByteArray> PartModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[DirtyRole] = "isDirty";
    roles[ChangeRole] = "isChanged";
    roles[SelectionRole] = "isSelect";

    roles[Qt::DisplayRole] = "display";
    roles[Qt::EditRole] = "data";
    return roles;
}


QVariant PartModel::data(const QModelIndex &index, int role) const
{
    MapData m = this->array[index.row()][index.column()];
    if (!index.isValid())
        return QVariant();
    switch(role){
    case ChangeRole:
        return !(this->connectedTable->data(this->connectedTable->index(m.map_r,m.map_c)).toString() == m.v.toString());
    case DirtyRole:
        return this->connectedTable->isDirty(connectedTable->index(m.map_r, m.map_c));
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
            this->writeBack(index.row(), index.column());
            emit dataChanged(index, index, QVector<int>({Qt::DisplayRole, ChangeRole, DirtyRole}));
            emit partDataChanged(index.row(), index.column(), value);
            return true;
        case Qt::DisplayRole:
            this->array[index.row()][index.column()].v = value;
            emit dataChanged(index, index, QVector<int>({Qt::DisplayRole, ChangeRole}));
            emit partDataChanged(index.row(), index.column(), value);
            return true;
        case SelectionRole:
            if(this->flags(index) == (Qt::ItemIsEditable | Qt::ItemIsSelectable | Qt::ItemIsEnabled)){
                this->selection[index.row()][index.column()] = value.toBool();
                emit dataChanged(index, index, QVector<int>({SelectionRole}));
                // emit partSelectChanged(index.row(), index.column(), value.toBool());
            }
            return true;

        case DirtyRole:
            emit dataChanged(index, index, QVector<int>({DirtyRole}));
            return true;
        }
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


bool PartModel::changeSelectIndex(int index)
{
    if(index >= parameterCouple.size())
        return false;

    this->header.clear();
    header.push_back("angle");
    if(parameterCouple[index].isCouple){
        header.push_back((index == 8 ? "lead"  : "") + parameterCouple[index].name + (index == 8 ? ""  : "_Lead"));
        header.push_back((index == 8 ? "trail" : "") + parameterCouple[index].name + (index == 8 ? "" : "_Trail"));
    }
    else
        header.push_back(parameterCouple[index].name);

    this->pullArray();

    return true;
}


bool PartModel::changeBackendTable(TModel *newConnectedTable)
{
    if(this->connectedTable != nullptr)
        QObject::disconnect(this->connectedTable, &TModel::refreshDirty, this, &PartModel::refresh);
    deleteArray();
    setConnectedTable(newConnectedTable);
    return true;
}


bool PartModel::pullArray()
{
    if(this->connectedTable == nullptr)
        return false;

    createArray(connectedTable->rowCount(), header.size());
    initializeSelection();

    for(int i = 0; i < connectedTable->rowCount(); i++){
        QSqlRecord r = connectedTable->record(i);
        int j = 0;
        for(int k = 0; k < r.count(); k++){
            if( j < header.size() && r.fieldName(k) == header[j]){
                this->array[i][j] = MapData(i, k, r.value(k));
                // emit partDataChanged(i, j, r.value(k));
                emit dataChanged(this->index(i, j), this->index(i, j), QVector<int>({Qt::DisplayRole, ChangeRole, DirtyRole}));
                j++;
            }
        }
    }

    QVariantList modelList = this->xyModel();
    QVariantList legendList = this->legendModel();
    emit dataReady(modelList, legendList);

    return true;
}


bool PartModel::pushArray()
{
    if(this->connectedTable == nullptr || this->array == nullptr)
        return false;

    for(unsigned int i = 0; i < this->r; i++){
        for(unsigned int j = 0; j < this->c; j++){
            if(this->data(this->index(i, j), ChangeRole).toBool()){
                writeBack(i, j);
            }
         }
    }
    return true;
}


bool PartModel::refresh()
{
    for(int i = 0; i < this->rowCount(); i++)
        for(int j = 0; j < this->columnCount(); j++){
            MapData m = this->array[i][j];
            this->setData(this->index(i, j), this->connectedTable->data(this->connectedTable->index(m.map_r, m.map_c), DirtyRole), DirtyRole);
            this->setData(this->index(i, j), this->connectedTable->data(this->connectedTable->index(m.map_r, m.map_c), Qt::DisplayRole));
        }
    return true;
}


// array create and destroy
void PartModel::createArray(unsigned int row, unsigned int col)
{
    beginResetModel();

    if(this->array != nullptr)
        deleteArray();

    this->r = row;
    this->c = col;

    this->array = new MapData*[row];
    for(unsigned int i = 0; i < row; i++)
        this->array[i] = new MapData[col];

    endResetModel();
}


void PartModel::deleteArray()
{
    emit dataDeleted();
    if(this->array == nullptr)
        return;
    for(unsigned int i = 0; i < this->r; i++){
        delete [] this->array[i];
    }
    delete this->array;
    this->array = nullptr;
    this->r = 0;
    this->c = 0;
}


void PartModel::writeBack(int row, int col)
{
    MapData m = this->array[row][col];
    this->connectedTable->setData(this->connectedTable->index(m.map_r, m.map_c), m.v);
}


// model getter and setter
TModel *PartModel::getConnectedTable() const
{
    return connectedTable;
}


void PartModel::setConnectedTable(TModel *newConnectedTable)
{
    connectedTable = newConnectedTable;
    QObject::connect(newConnectedTable, &TModel::refreshDirty, this, &PartModel::refresh);
}


QString PartModel::headerNameEng(unsigned int i)
{
    return this->header[i];
}


void PartModel::callSetData(int row, int col, QVariant v)
{
    QModelIndex i = this->index(row, col);
    this->setData(i, v);
}


// selection related function
bool PartModel::callAddToModel(double v, bool isAdd)
{
    for(int i = 0; i < this->rowCount(); i++){
        for(int j = 1; j < this->columnCount(); j++){
            if(this->selection[i][j] == true){
                QVariant oldData = this->data(this->index(i,j));
                double newData = isAdd? (oldData.toDouble() + v) : (oldData.toDouble() - v);
                int round = digitsAfterDecimal(newData);
                if(round == 0)
                    this->setData(this->index(i,j), QVariant(int(newData)));
                else{
                    double multiplier = std::pow(10.0, round);
                    this->setData(this->index(i,j), QVariant(std::round(newData * multiplier)/multiplier), Qt::DisplayRole);
                }
            }
        }
    }
    return true;
}

bool PartModel::callSetToModel(double v)
{
    for(int i = 0; i < this->rowCount(); i++){
        for(int j = 1; j < this->columnCount(); j++){
            if(this->selection[i][j] == true){
                QVariant oldData = this->data(this->index(i,j));
                double newData = v;
                int round = digitsAfterDecimal(newData);
                if(round == 0)
                    this->setData(this->index(i,j), QVariant(int(newData)));
                else{
                    double multiplier = std::pow(10.0, round);
                    this->setData(this->index(i,j), QVariant(std::round(newData * multiplier)/multiplier), Qt::DisplayRole);
                }
            }
        }
    }
    return true;
}


void PartModel::callWriteBack()
{
    this->pushArray();
}


void PartModel::callFetchData()
{
    this->pullArray();
}


void PartModel::clear()
{
    this->header.clear();
    this->deleteArray();
    this->releaseSelection();

    emit dataDeleted();
}

bool PartModel::isReady()
{
    return !(connectedTable == nullptr);
}


void PartModel::callCrossSelect(unsigned int row, unsigned int col, bool b)
{
    this->selection[row][col] = this->selection[row][col] & b;
    emit dataChanged(this->index(row, col), this->index(row, col), QVector<int>({SelectionRole}));
}

void PartModel::callSetSelect(unsigned int row, unsigned int col, bool b)
{
    this->setData(this->index(row, col), b, SelectionRole);
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
        delete [] this->selection[i];
        this->selection[i] = nullptr;
    }

    delete this->selection;
    this->selection = nullptr;
}


QVariantList PartModel::xyModel()
{
    QVariantList list;

    for(int i = 0; i < this->columnCount(); i++){
        QVariantList l;
        for(int j = 0; j < this->rowCount(); j ++)
            l.append(this->array[j][i].v);
        list.append(QVariant(l));
    }

    return list;
}


QVariantList PartModel::legendModel()
{
    QVariantList list;
    for(int i = 1; i < this->header.size(); i++)
        list.append(QVariant(this->header[i]));
    return list;
}


QString PartModel::webData()
{
    QString s;
    s += QString::number(this->columnCount()) + " ";

    for(int i = 1; i < this->header.size(); i++){
        s += this->header[i] + " ";
    }

    if(this->columnCount() < 3)
        s += "null ";

    for(int i = 0; i < this->columnCount(); i++){
        for(int j = 0; j < this->rowCount(); j ++)
            s += this->array[j][i].v.toString() + " ";
    }
    return s;
}
