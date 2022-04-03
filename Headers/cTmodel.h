#ifndef CDBMODEL_H
#define CDBMODEL_H
#include <QSqlTableModel>
#include <QList>
#include <cparamdatabase.h>
#include <cdatabase.h>

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
        DirtyRole
    };

    QHash<int, QByteArray> roleNames() const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

public slots:

    QVariant fixedTablePopData(unsigned int, QString);

    void callSetData(unsigned int row, unsigned int col, QVariant v);

    QVariant callGetData(unsigned int i, unsigned int j);

    QString headerNameEng(unsigned int i);

    void callSubmit();

    void callRevert();

    bool callIsDirty(unsigned int row, unsigned int col);

    bool callIsDirty();

    QVector<QString>* getTableQuery(); // this is for angular table

    QString getRowQuery(int index); // this is for fixed table

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

    void refreshDirty();

    void modelSingleDataChanged(unsigned int i, unsigned int j, QVariant v);

private:

    QString rowQuery(int i);
};

#endif // CDBMODEL_H
