#ifndef TABLEWIDGET_H
#define TABLEWIDGET_H

#include <QObject>
#include <QWidget>
#include <QGridLayout>
#include <QPair>
#include <QTableWidget>

#include <vector>

#include <QHeaderView>
class tableWidget : public QWidget
{
    Q_OBJECT
public:
    explicit tableWidget(QWidget *parent = nullptr);
public slots:
    void SlotTakeField_fromMainWindow();
    void SlotTaleField_fromField(std::vector<QPair<int,int>>);
signals:
    void SignalTakeField_toField();
private:
    QGridLayout* layout;
    std::vector<QPair<int,int>> table_vector;
    QTableWidget* table;
};

#endif // TABLEWIDGET_H
