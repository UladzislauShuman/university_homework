#include "cell.h"

Cell::Cell()
{
    connect(this, &Cell::QPushButton::clicked, this, &Cell::OnClick);
}

Cell::Cell(QColor color_, int x_, int y_)
{
    //qDebug() << "Cell::Cell(color,int,int)"<<Qt::endl;
    connect(this, &Cell::QPushButton::clicked, this, &Cell::OnClick);
    this->color = color_;
    this->x_pos = x_;
    this->y_pos = y_;
    this->flag = false;//по дефолту не прожата
    QString style = QString("QPushButton { background-color: %1 }").arg(this->color.name());
    this->setStyleSheet(style);
    this->Win = false;
}

Cell::Cell(int x_, int y_)
{
    //qDebug() << "Cell::Cell(int,int)"<<Qt::endl;
    connect(this, &Cell::QPushButton::clicked, this, &Cell::OnClick);
    this->color = Qt::black;
    this->x_pos = x_;
    this->y_pos = y_;
    this->flag = false;//по дефолту не прожата
    QString style = QString("QPushButton { background-color: %1 }").arg(this->color.name());
    this->setStyleSheet(style);
    this->Win = false;
}

Cell::Cell(int x_, int y_, bool)
{
    //qDebug() << "Cell::Cell(int,int,bool)"<<Qt::endl;
    connect(this, &Cell::QPushButton::clicked, this, &Cell::OnClick);
    this->color = Qt::white;
    this->x_pos = x_;
    this->y_pos = y_;
    this->setText(QString::number(x_)+" "+QString::number(y_));
    this->flag = false;//по дефолту не прожата
    QString style = QString("QPushButton { background-color: %1 }").arg(this->color.name());
    this->setStyleSheet(style);
    this->Win = false;
}

void Cell::OnClick()
{
    emit SignalPosition(this->x_pos,this->y_pos);
}

void Cell::FillColor()
{
    //qDebug() << "Cell::FillColor()"<<Qt::endl;
    QString style = QString("QPushButton { background-color: %1 }").arg(this->color.name());
    this->setStyleSheet(style);
}

void Cell::SetNoColor()
{
    //qDebug() << "Cell::SetNoColor()"<<Qt::endl;
    this->setStyleSheet("QPushButton { background-color: black; }");
}

bool Cell::operator==(Cell& cell)
{
    //qDebug() << "Cell::opertator==()"<<Qt::endl;
    return (this->x_pos == cell.x_pos and this->y_pos == cell.y_pos);
}

QString StringStyle(QColor color)
{
    //qDebug() << "Cell::StringStyle()"<<Qt::endl;
    return QString("QPushButton { background-color: %1 }").arg(color.name());
}
