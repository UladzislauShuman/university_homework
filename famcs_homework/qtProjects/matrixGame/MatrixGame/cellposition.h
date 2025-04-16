#ifndef CELLPOSITION_H
#define CELLPOSITION_H
#include <QDebug>

class CellPosition
{
public:
    CellPosition();
    CellPosition(int x_, int y_):x(x_),y(y_){
        //qDebug() << "CellPosition::CellPosition(int,int)"<<Qt::endl;
    }
    ~CellPosition() = default;

    void SetX(int x_){
        //qDebug() << "CellPosition::SetX()"<<Qt::endl;
        this->x = x_;}
    int X(){
        //qDebug() << "CellPosition::X()"<<Qt::endl;
        return this->x;}
    void SetY(int y_){
        //qDebug() << "CellPosition::SetY()"<<Qt::endl;
        this->y = y_;}
    int Y(){
        //qDebug() << "CellPosition::Y()"<<Qt::endl;
        return this->y;}
private:
    int x;
    int y;
};

#endif // CELLPOSITION_H
