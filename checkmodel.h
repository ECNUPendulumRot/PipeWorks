#ifndef CHECKMODEL_H
#define CHECKMODEL_H

#include <QAbstractTableModel>
#include <QList>

typedef QList<bool> CheckList ;
class CheckModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit CheckModel(QObject *parent = nullptr);

    enum TableRoles {
        CheckRole = Qt::UserRole + 1
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    QHash<int ,QByteArray> roleNames() const override;


public slots:

    void append(bool b);

    void clear();

    void reset();

    void set(bool);

    bool at(int i);

signals:
    void checkChanged(int index, bool b);


private:
    CheckList list;

};

#endif // CHECKMODEL_H
