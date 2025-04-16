#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QPainter>
#include <vector>
#include "stack.h"

QT_BEGIN_NAMESPACE
namespace Ui {
    class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget* parent = nullptr);
    void LoadFile(const QString&);
    ~MainWindow();

protected:
    void paintEvent(QPaintEvent*);

private slots:
    void on_pushButton_clicked();

    void on_pushButtonPush_clicked();

    void on_pushButtonPop_clicked();

private:
    int stackSize;
    Ui::MainWindow* ui;
    Stack stack;
    QPen pen;
    QFont font;
};

#endif // MAINWINDOW_H
