#ifndef MYQCOLOR_H
#define MYQCOLOR_H

#include <QDebug>
#include <QColor>

class MyQColor : public QColor
{
public:
    MyQColor():color(Qt::black){}
    MyQColor(QColor color_):color(color_){}
    MyQColor(int r,int g,int b):color(QColor(r,g,b)){
        //qDebug() << "MyQColor::MyQColor(int,int,int)"<<Qt::endl;
    }
    ~MyQColor() = default;

    QColor GetColor(){
        //qDebug() << "MyQColor::GetColor()"<<Qt::endl;
        return this->color;}
    friend bool operator<( const MyQColor A,const MyQColor B);
    friend bool operator==( const MyQColor A,const MyQColor B);
private:
    QColor color;
};

#endif // MYQCOLOR_H
