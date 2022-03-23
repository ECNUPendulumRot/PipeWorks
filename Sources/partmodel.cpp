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

    // pair role for edit and display
    roles[Qt::DisplayRole] = "display";
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

    QList<QString> l;
    l.push_back("angle");
    if(parameterCouple[index].isCouple){
        l.push_back((index == 8 ? "lead"  : "") + parameterCouple[index].name + (index == 8 ? ""  : "_Lead"));
        l.push_back((index == 8 ? "trail" : "") + parameterCouple[index].name + (index == 8 ? "l" : "_Trail"));
    }
    else
        l.push_back(parameterCouple[index].name);

# ifdef QT_DEBUG
    qDebug() << "start pulling array...";
    QString s;
    for(int i = 0; i < l.size(); i ++){
        s += l[i] + " ";
    }
    qDebug() << "Content is" << s;
# endif
    pullArray(l);
# ifdef QT_DEBUG
    qDebug() << "finish pulling array...";
    //qDebug() << "row column counts:" << this->rowCount() << " ," << this->columnCount();
# endif
    QString forWeb = this->webData(l);

# ifdef QT_DEBUG
    qDebug() << forWeb;
    //qDebug() << "row column counts:" << this->rowCount() << " ," << this->columnCount();
# endif

    emit this->dataReady(forWeb);

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
    if(this->connectedTable == nullptr)
        return false;

    // body

    createArray(connectedTable->rowCount(), l.size());
    initializeSelection();

    for(int i = 0; i < connectedTable->rowCount(); i++){
        QSqlRecord r = connectedTable->record(i);
        int j = 0;

        for(int k = 0; k < r.count(); k++){
            if( j < l.size() && r.fieldName(k) == l[j]){
                this->array[i][j] = MapData(i, k, r.value(k));
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
    this->array = nullptr;
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

QString PartModel::headerNameEng(unsigned int i)
{
    return this->connectedTable->record().fieldName(i);
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
                    this->setData(this->index(i,j), QVariant(std::round(newData * multiplier)/multiplier));
                }
            }
        }
    }
    return true;
}


void PartModel::clear()
{
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


QString PartModel::webData(QList<QString> header)
{
    QString s;
    s += QString::number(this->columnCount()) + " ";

    for(int i = 1; i < header.size(); i++){
        s += engToChn[header[i]] + " ";
    }

    if(this->columnCount() < 3)
        s += "null ";

    for(int i = 1; i < this->columnCount(); i++){
        for(int j = 0; j < this->rowCount(); j ++)
            s += this->array[j][i].v.toString() + " ";
    }
    return s;
}
