#ifndef CDBMODEL_H
#define CDBMODEL_H
#include <QSqlTableModel>
#include <QList>
#include <cparamdatabase.h>
#include <cdatabase.h>

typedef struct Parameter {
    QString name;
    QString chn;
    bool isCouple;
    Parameter(){};
    ~Parameter(){};
    Parameter(QString n, QString c, bool is):name(n), chn(c), isCouple(is)
    {};

} Parameter;

class TModel: public QSqlTableModel //truncate model,used to choose specific data from table
{
    Q_OBJECT
public:

    TModel();

    explicit TModel(QSqlDatabase &db);

    ~TModel();

    QString truncate(QList<unsigned int> cl);//column list

    enum TableRoles{
        ColumnRole = Qt::UserRole + 1,
        RowRole,
        DirtyRole,
        SelectionRole
    };

    QHash<int, QByteArray> roleNames() const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;



public slots:

    QString callWebData();

    QVariant fixedTablePopData(unsigned int, QString);

    void callSetData(unsigned int row, unsigned int col, QVariant v);

    QVariant callGetData(unsigned int i, unsigned int j);

    QString headerNameEng(unsigned int i);

    void callSubmit();

    void callRevert();

    bool callIsDirty(unsigned int row, unsigned int col);

    bool callIsDirty();

    //bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;

    void callCrossSelect(unsigned int row, unsigned int col, bool b);

    void callSetSelect(unsigned int row, unsigned int col, bool b);

    bool select() override;

    //bool callAddToModel(double v, bool isAdd);

signals:

    ///
    /// \brief modelDataChanged:
    ///         this signal is used for refreshing webview when user submit, revert or close the database
    /// \param s
    ///
    void modelDataChanged(QString s);

    ///
    /// \brief modelChanged
    ///         if truncated, then emit this signal
    /// \param s
    ///
    void modelChanged(QString s);


    void modelSingleDataChanged(unsigned int i, unsigned int j, QVariant v);

private:

    bool **selection = nullptr;

    QString getChn(QString s);

    void initializeSelection();

    void releaseSelection();


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
                                         {8,    Parameter("TargetCur"      , QStringLiteral("垂向目标值"), true)},
                                     });

    static inline QHash<QString, QString> engToChn =
            QHash<QString, QString>({
                                        {"angle",               "角度"},
                                        {"stayTime_Lead",       "前枪边停时间"},
                                        {"stayTime_Trail",      "后枪边停时间"},
                                        {"oscWidth_Lead",       "前枪摆宽"},
                                        {"oscWidth_Trail",      "后枪摆宽"},
                                        {"oscFreq_Lead",        "前枪摆动周期"},
                                        {"oscFreq_Trail",       "后枪摆动周期"},
                                        {"feedRate_Lead",       "前枪送丝速度"},
                                        {"feedRate_Trail",      "后枪送丝速度"},
                                        {"Arc_Rate_Lead",       "前枪电弧修正"},
                                        {"Arc_Rate_Trail",      "后枪电弧修正"},
                                        {"leadTargetCur",       "前枪垂向目标值"},
                                        {"trailTargetCur",      "后枪垂向目标值"},
                                        {"carACC",              "小车加速度"},
                                        {"carSPEED",            "小车速度"},

                                    });


};

#endif // CDBMODEL_H
