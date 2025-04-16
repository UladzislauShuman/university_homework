#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTimer>
#include <QMessageBox>
#include <QPainter>
#include <QColorDialog>
#include "centerdialog.h"
#include "speeddialog.h"

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void on_colorButton_clicked();
    void on_increaseSpeedButton_clicked();
    void on_decreaseSpeedButton_clicked();
    void on_actionSetCenter_triggered();
    void on_actionSetSpeed_triggered();

    void on_setRadiusButton_clicked();

protected:
    void paintEvent(QPaintEvent*);
    void timerSlot();

private:
    Ui::MainWindow *ui;
    QTimer* timer;
    QPen* pen;
    QColor color;
    int radius{100};
    int maxRadius{250};
    int delay{40};
    QPoint* center;
    bool isIncreasing{true};

    CenterDialog* centerDialog;
    SpeedDialog* speedDialog;
};
#endif // MAINWINDOW_H
