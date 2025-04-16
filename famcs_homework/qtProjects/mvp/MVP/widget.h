#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include <QPushButton>

QT_BEGIN_NAMESPACE
namespace Ui {
class Widget;
}
QT_END_NAMESPACE

class Widget : public QWidget
{
    Q_OBJECT

public:
    Widget(QWidget *parent = nullptr);
    ~Widget();

private:
    Ui::Widget *ui;

private slots:
    void ClickSlotMasha1();
    void ClickSlotMasha2();
    void ClickSlotMasha3();
    void ClickSlotMasha4();
    void ClickSlotMasha5();

    void ClickTab1To2();
    void ClickTab2To1();

};
#endif // WIDGET_H
