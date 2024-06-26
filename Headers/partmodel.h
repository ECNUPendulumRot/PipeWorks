﻿#ifndef PARTMODEL_H
#define PARTMODEL_H

#include <QAbstractItemModel>
#include <cTmodel.h>

//typedef struct Parameter {
//    QString name;
//    QString chn;
//    bool isCouple;
//    Parameter(){};
//    ~Parameter(){};
//    Parameter(QString n, QString c, bool is):name(n), chn(c), isCouple(is)
//    {};

//} Parameter;

typedef struct MapData{
    int map_r;
    int map_c;

    QVariant v;

    MapData(){};
    ~MapData(){};
    MapData(int r, int c, QVariant v):map_r(r), map_c(c), v(v)
    {};

} MapData;


class PartModel : public QAbstractItemModel
{
    Q_OBJECT
public:
    explicit PartModel(QObject *parent = nullptr);

    // Basic functionality:

    enum TableRoles{
        ColumnRole = Qt::UserRole + 1,
        RowRole,
        DirtyRole,
        ChangeRole,
        SelectionRole
    };

    QModelIndex index(int row, int column,
                      const QModelIndex &parent = QModelIndex()) const override;

    // what is it? need to be fixeds
    QModelIndex parent(const QModelIndex &index) const override;

    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    Q_INVOKABLE int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;


    // array related operation
    // only for angular related table
    bool changeSelectIndex(int index);

    bool changeBackendTable(TModel *newConnectedTable);

    bool pullArray();

    bool pushArray();

    bool refresh();

    // model related operation
    TModel *getConnectedTable() const;

    void setConnectedTable(TModel *newConnectedTable);


    // selection related operation
    void callCrossSelect(unsigned int row, unsigned int col, bool b);

    void clear();

    QString webData();

public slots:

    QString headerNameEng(unsigned int i);

    void callSetData(int i, int j, QVariant v);

    void callSetSelect(unsigned int row, unsigned int col, bool b);

    bool callAddToModel(double v, bool isAdd);

    void callWriteBack();

    void callFetchData();

signals:

    void dataReady(QString s);

    void partDataChanged(int r, int c, QVariant v);

    void partSelectChanged(int r, int c, bool b);

private:

    // selection related operation
    bool **selection = nullptr;

    void initializeSelection();

    void releaseSelection();

    // array related operation
    MapData **array = nullptr;

    QList<QString> header;

    unsigned int r = 0, c = 0;

    void createArray(unsigned int row, unsigned int col);

    void deleteArray();

    void writeBack(int row, int col);

    TModel *connectedTable = nullptr;

    static inline QHash<unsigned int, Parameter> parameterCouple =
        QHash<unsigned int, Parameter>({//cmd <------> table column name
                                         {0,    Parameter("angle"          , QStringLiteral("角度"), false)},
                                         {1,    Parameter("stayTime"       , QStringLiteral("边停时间"),true)},
                                         {2,    Parameter("oscWidth"       , QStringLiteral("摆宽"), true)},
                                         {3,    Parameter("oscFreq"        , QStringLiteral("摆动周期"), true)},
                                         {4,    Parameter("feedRate"       , QStringLiteral("送丝速度"), true)},
                                         {5,    Parameter("Arc_Rate"       , QStringLiteral("电弧修正"), true)},
                                         {6,    Parameter("carACC"         , QStringLiteral("小车加速度"), false)},
                                         {7,    Parameter("carSPEED"       , QStringLiteral("小车速度"), false)},
                                         {8,    Parameter("TargetCur"      , QStringLiteral("干伸高度值"), true)},
                                     });
};

#endif // PARTMODEL_H
