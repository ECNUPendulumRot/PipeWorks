#include "partmodel.h"
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
    //qDebug() << "call rowCount: r = " << r;
    // customize:
    return this->r;
}

int PartModel::columnCount(const QModelIndex &parent) const
{
    //qDebug() << "call columnCount: c = " << c;
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

    roles[Qt::DisplayRole] = "display";
    roles[Qt::EditRole] = "data";
    return roles;
}


QVariant PartModel::data(const QModelIndex &index, int role) const
{

# ifdef QT_DEBUG
    qDebug() << "data called at ("<<
                index.row() << "," << index.column()<< ") The role is : " << role;
# endif
    MapData m = this->array[index.row()][index.column()];
    if (!index.isValid())
        return QVariant();
    switch(role){
    case ColumnRole:
        return index.column();
    case RowRole:
        return index.row();
    case ChangeRole:
        return !(this->connectedTable->data(this->connectedTable->index(m.map_r,m.map_c)).toString() == m.v.toString());
    case DirtyRole:
        qDebug() << "dirty role : " << this->connectedTable->data(this->connectedTable->index(m.map_r, m.map_c)).toString()
                                    << this->connectedTable->isDirty(connectedTable->index(m.map_r, m.map_c));
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
# ifdef QT_DEBUG
    qDebug() << "set data called at ("<<
                index.row() << "," << index.column()<< ") The role is : " << role;
# endif

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

    this->header.clear();
    //QList<QString> l;
    header.push_back("angle");
    if(parameterCouple[index].isCouple){
        header.push_back((index == 8 ? "lead"  : "") + parameterCouple[index].name + (index == 8 ? ""  : "_Lead"));
        header.push_back((index == 8 ? "trail" : "") + parameterCouple[index].name + (index == 8 ? "" : "_Trail"));
    }
    else
        header.push_back(parameterCouple[index].name);

# ifdef QT_DEBUG
    qDebug() << "start pulling array...";
    QString s;
    for(int i = 0; i < header.size(); i ++){
        s += header[i] + " ";
    }
    qDebug() << "Content is" << s;
# endif
    pullArray();
# ifdef QT_DEBUG
    qDebug() << "finish pulling array...";
    //qDebug() << "row column counts:" << this->rowCount() << " ," << this->columnCount();
# endif
    QString forWeb = this->webData();
    emit this->dataReady(forWeb);

    return true;
}

bool PartModel::changeBackendTable(TModel *newConnectedTable)
{
    deleteArray();
    setConnectedTable(newConnectedTable);
    return true;
}

bool PartModel::pullArray()
// Pop data by header name list L and push them into array
{
    if(this->connectedTable == nullptr)
        return false;

    // body

    createArray(connectedTable->rowCount(), header.size());
    initializeSelection();

    for(int i = 0; i < connectedTable->rowCount(); i++){
        QSqlRecord r = connectedTable->record(i);
        int j = 0;

        for(int k = 0; k < r.count(); k++){
            if( j < header.size() && r.fieldName(k) == header[j]){
                this->array[i][j] = MapData(i, k, r.value(k));
                emit dataChanged(this->index(i, j), this->index(i, j), QVector<int>({Qt::DisplayRole, ChangeRole, DirtyRole}));
                j++;
            }
        }
    }
    // body
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

# ifdef QT_DEBUG
        qDebug() << "start delete ...";
# endif
    for(unsigned int i = 0; i < this->r; i++){
        delete [] this->array[i];
# ifdef QT_DEBUG
        qDebug() << "deleted " << i;
# endif
    }
    delete this->array;
    this->array = nullptr;
    this->r = 0;
    this->c = 0;
}

void PartModel::writeBack(int row, int col)
{
# ifdef QT_DEBUG
    qDebug() << "writing back started...";
#endif
    MapData m = this->array[row][col];
    this->connectedTable->setData(this->connectedTable->index(m.map_r, m.map_c), m.v);
# ifdef QT_DEBUG
    qDebug() << "writing back end. Current data is " << this->connectedTable->data(this->connectedTable->index(m.map_r, m.map_r)).toString();
#endif
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

QString PartModel::headerNameEng(unsigned int i)
{
    return this->header[i];
}


// selection related function
bool PartModel::callAddToModel(double v, bool isAdd)
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


QString PartModel::webData()
{
    QString s;
    s += QString::number(this->columnCount()) + " ";

    for(int i = 1; i < this->header.size(); i++){
        s += this->header[i] + " ";
    }

    if(this->columnCount() < 3)
        s += "null ";

    for(int i = 1; i < this->columnCount(); i++){
        for(int j = 0; j < this->rowCount(); j ++)
            s += this->array[j][i].v.toString() + " ";
    }
    return s;
}
