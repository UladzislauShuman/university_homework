#ifndef BOATDIALOG_H
#define BOATDIALOG_H

#include <QDialog>
#include <QTimer>
#include <QMessageBox>

#include <QPainter>
#include <QPainterPath>
#include <QLineF>
#include <QColor>
#include <QPointF>

#include <QString>
#include <QFileDialog>

//stl
#include <vector>
#include <string>
#include <fstream>
#include <algorithm>

#include "settingsdialog.h"
namespace Ui {
class BoatDialog;
}

class BoatDialog : public QDialog
{
    Q_OBJECT

public:
    explicit BoatDialog(QWidget *parent = nullptr);
    ~BoatDialog();

protected:
    void paintEvent(QPaintEvent*);
    void timeSlot();

    void drawWater(QPainter&, double,int,int,QColor);
    void drawBoat(QPainter& ,int,int,int,int);
    void drawFlag(QPainter&,int height, int width,int x0,int y0);
private slots:
    void on_changeButton_clicked();
    void on_pushButton_clicked();
public slots:
    void takeSettings(int,int,int,int);
    void takeBoatColor(QColor);
    void takeFlagColor(QColor);
private:
    Ui::BoatDialog *ui;
    QTimer* timer;
    QPen* pen;
    double interval = 0;
    int delay = 150;
    bool isUp{true};
    int maxflag{5};
    int flag{0};
    int flagDelay{0};

    SettingsDialog* settingsdialog;

    int x_boatPos{this->width()/2};
    int y_boatPos{2*this->height()/3};
    int width_boat{this->width()/3};
    int height_boat{this->height()/4};
    QColor color_boat{Qt::yellow};
    QColor color_flag{Qt::red};

    bool proverka(int x_pos,int y_pos,int width,int height);
};

#endif // BOATDIALOG_H
