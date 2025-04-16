#ifndef FIELD_H
#define FIELD_H

#include <QObject>
#include <QGridLayout>
#include <QPushButton>
#include <QRandomGenerator>
#include <QSizePolicy>
#include <QDebug>
#include <QTimer>

#include <vector>
#include <set>
#include <unordered_set>
#include <ctime>

//для перемешивания vector
#include <random>
#include <algorithm>
#include <chrono>

#include "cell.h"
#include "cellposition.h"
#include "myqcolor.h"
#include "windialog.h"
#include "player.h"

class Field : public QObject
{
    Q_OBJECT
public:
    explicit Field(QObject *parent = nullptr);
    Field();
    Field(int width_,int height_,int attempts_ = 1000);
    Field(Player);
    ~Field();

    QGridLayout* GetLayout(){
        qDebug() << "Field::GetLayout()"<<Qt::endl;
        return layout;}
    WinDialog* GetWinDialog(){
        qDebug() << "Field::GetWinDialog()"<<Qt::endl;
        return windialog;}
    int GetHeight(){return this->height;}
    int GetWidth(){return this->width;}
public slots:
    void takePos(int, int);
    void mainAlgorithm(int,int);
private slots:
    void slotForTimer();
signals:
    void SignalXY_current(int,int);
    void SignalTextMessage(QString,bool);
    void SignalAttempts(int);
private:
    int height;
    int width;
    std::vector<std::vector<Cell*>> field;
    std::vector<CellPosition> cells_positions;
    QGridLayout* layout;
    WinDialog* windialog;


    // координаты первой нажатой
    int x1;int y1;
    //координаты второй нажатой
    int x2;int y2;
   // bool flag; // true -- нажата
    int current_amount;

    void SetPareWin();
    void SetPareOff();
    void FillField();

    void MyDebug(int,int,QString);
    int CheckButton(int,int);

    int amount_colored;
    int attempts;
    bool isFieldWin();

    QTimer* timer;
    int interval{1000};
    void TurnAllOn();
    void TurnAllOff();
};
/*
 * алгоритм проверки будет проходить на поле
 * при нажатии кнопки та передаёт инфу, что мол -- вот моя позиция
 * а далее по этой позиции уже в Field мы её находим и спокойно рассматрвием
 * причина проста : до этого был написал сигнал, в котором передаётся позиция клетки
 */

#endif // FIELD_H
