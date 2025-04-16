#ifndef FIELDWIDGET_H
#define FIELDWIDGET_H

#include <QObject>
#include <QWidget>
#include <QDebug>

#include <QLabel>
#include <QGridLayout>

#include <QFile>
#include <QTextStream>

#include <QString>
#include <QStringList>
#include <QPair>

#include <QPainter>
#include <QPainterPath>
#include <QLineF>
#include <QColor>
#include <QPointF>
//#include <QMouseEvent>

#include <vector>

class FieldWidget : public QWidget
{
    Q_OBJECT
public:
    explicit FieldWidget(QWidget *parent = nullptr);
    QGridLayout* GetLayout(){return this->layout;}
    void PrintFrield(QPainter&);
    void Clear(){this->field.clear();this->update();}
protected:
    void paintEvent(QPaintEvent*);
   // void mousePressEvent(QMouseEvent*);
signals:
    void SignalVector_toTable(std::vector<QPair<int,int>>);
public slots:
    void SlotGetFileName_fromMainWindow(QString);
    void SlotGetColor_fromMainWindow(QColor);
    void SlotIsFill_fromMainWindow(bool);
    void SlotPoint_fromMainWindow(QPair<int,int>);
    void SlotClean_fromMainWindow();
    void SlotToSave_fromMainWindow(QString);
    void SlotGetBack_fromMainWindow();

    void SlotTakeField_fromTable();
private:
    QLabel* label;
    QGridLayout* layout;
    std::vector<QPair<int,int>> field;

    QPen* pen;
    QColor current_color;
    bool isFill{false};
    int amount_of_pressing{0};
};

#endif // FIELDWIDGET_H
