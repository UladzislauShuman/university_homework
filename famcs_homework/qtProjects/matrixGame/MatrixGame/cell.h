#ifndef CELL_H
#define CELL_H

#include <QPushButton>
#include <QColor>
#include <QString>
#include <QSizePolicy>

class Cell : public QPushButton
{
    Q_OBJECT
public:
    Cell();
    // задаёт кнопку и её позицию в массиве
    Cell(QColor,int,int);
    Cell(int,int);

    Cell(int,int,bool);
    //очевидно из определения
    int X(){
        //qDebug() << "Cell::X()"<<Qt::endl;
        return x_pos;}
    void SetX(int x_){
        //qDebug() << "Cell::SetX()"<<Qt::endl;
        this->x_pos = x_;
    }
    int Y(){
        //qDebug() << "Cell::Y()"<<Qt::endl;
        return y_pos;}
    void SetY(int y_){
        //qDebug() << "Cell::SetY()"<<Qt::endl;
        this->y_pos = y_;}

    QColor GetColor(){
        //qDebug() << "Cell::GetColor()"<<Qt::endl;
        return color;}
    void SetColor(QColor color_){
        //qDebug() << "Cell::SetColor()"<<Qt::endl;
        this->color = color_;}
    bool isEmpty(){
        //qDebug() << "Cell::isEmpty()"<<Qt::endl;
        return this->color == Qt::black;}
    void FillColor();

    bool isWin(){
        //qDebug() << "Cell::isWin()"<<Qt::endl;
        return this->Win;}
    void setWin(bool Win_){
        //qDebug() << "Cell::setWin()"<<Qt::endl;
        this->Win = Win_;}

    bool Flag(){
        //qDebug() << "Cell::Flag()"<<Qt::endl;
        return this->flag;}
    void setFlag(bool flag_){
        //qDebug() << "Cell::setFlag()"<<Qt::endl;
        this->flag = flag_;}

    void SetNoColor();

    bool operator==(Cell&);
public slots:
    //надо было свой собственный слот для нажатия написать
    void OnClick();
private:
    QColor color;
    int x_pos;
    int y_pos;
    bool flag;// true -- нажата
    bool Win;
protected:
    void resizeEvent(QResizeEvent *event) override {
        QPushButton::resizeEvent(event);
        setFixedSize(width(), width()); // Устанавливаем ширину равной высоте
    }
signals:
    void SignalPosition(int,int);
};

//правильная строка для имзенения цвета кнопки
QString StringStyle(QColor);
#endif // CELL_H
