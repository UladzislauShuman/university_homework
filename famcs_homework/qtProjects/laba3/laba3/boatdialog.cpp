#include "boatdialog.h"
#include "ui_boatdialog.h"
#include <iostream>
BoatDialog::BoatDialog(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::BoatDialog)
{
    ui->setupUi(this);
    pen = new QPen();
    timer = new QTimer();
    timer->setInterval(delay);
    isUp = true;
    flag = 0;
    maxflag = 5;
    settingsdialog = new SettingsDialog();
    x_boatPos = this->width()/2;
    y_boatPos = 2*this->height()/3;
    width_boat = this->width()/3;
    height_boat = this->height()/4;

    connect(timer,&QTimer::timeout,this,&BoatDialog::timeSlot);
    connect(settingsdialog,&SettingsDialog::SignalSettings,this,&BoatDialog::takeSettings);
    connect(settingsdialog,&SettingsDialog::SignalColorBoat,this,&BoatDialog::takeBoatColor);
    connect(settingsdialog,&SettingsDialog::SignalColorFlag,this,&BoatDialog::takeFlagColor);
    timer->start();
}

BoatDialog::~BoatDialog()
{
    delete pen;
    delete timer;
    delete settingsdialog;
    delete ui;
}

void BoatDialog::paintEvent(QPaintEvent* event)
{
    QPainter painter(this);
    painter.begin(this);

    //вода
    int waterHeight = this->height()/3 *2;
    int waterWidth = 40;
    drawWater(painter,1.0, waterWidth,waterHeight,Qt::blue);
    drawWater(painter,2.0, waterWidth/1.3,waterHeight*1.2,Qt::darkCyan);
    drawWater(painter,3.0, waterWidth/1.6,waterHeight*1.4,Qt::darkBlue);
    drawBoat(painter,this->width_boat,this->height_boat,this->x_boatPos,this->y_boatPos);
    painter.end();
}

void BoatDialog::timeSlot()
{
    this->update();
}

void BoatDialog::drawWater(QPainter& painter, double kef,int width, int height,QColor color)
{
    pen->setColor(color);
    pen->setWidth(10);

    if(this->interval >= M_PI * 2){
        this->interval = 0;
    }
    else{
        this->interval += (M_PI*2/20);
    }
    QPainterPath path;

    path.moveTo(QPointF(0,std::sin(this->interval*kef) * 20 + height));
    for(double i = 0;i < this->width();i++){
        path.lineTo(QPointF(i,std::sin(i/width + this->interval*kef) * 20 + height));
    }
    path.lineTo(QPointF(this->width(),this->height()));
    path.lineTo(QPointF(0,this->height()));
    path.lineTo(QPointF(0,std::sin(this->interval*kef)*20 + height));
    painter.drawPath(path);
    painter.fillPath(path,QBrush(color));
}
double Y(double a, double x,double b)
{
    return (double)b*std::sqrt(1-(double)(x*x/a/a));
}
void BoatDialog::drawBoat(QPainter& painter, int width, int height, int x, int y)
{
    x -= width/2 ;
    y -= height/2;

    pen->setColor(this->color_boat);
    pen->setWidth(2);
    painter.setPen(*pen);

    QPainterPath path;
    //палуба
    path.moveTo(QPointF(x,y+2*(double)height/3));
    path.lineTo(QPointF(x+width,y+2*(double)height/3));
    double a = 0.5 * width;
    double b = 0.3333333333 * height;
    int x0 = x+width,y0 = y+2*(double)height/3;

    path.lineTo(QPointF(x0-50,(int)y0+Y(a,a-50,b)));
    for (int i = 0; i < 2*a; i+=1){
        path.lineTo(QPointF(x0-i,(int)y0+Y(a,a-i,b)));
    }
    path.lineTo(QPointF(x,y+2*(double)height/3));
    painter.fillPath(path,QBrush(this->color_boat));
    painter.drawPath(path);
    //шест
    path.clear();
    path.moveTo(QPointF(x+width/2,y+2*(double)(height/3)));
    path.lineTo(QPointF(x+width/2,y));
    pen->setWidth((double)width/(15));
    painter.setPen(*pen);
    painter.drawPath(path);
    //флаг
    drawFlag(painter,height,width,x,y);
}

void BoatDialog::drawFlag(QPainter& painter,int height, int width,int x0,int y0)
{

    if(this->flagDelay != delay){
        this->flagDelay += delay/10;
    }
    else{
        this->flagDelay = 0;

        if(this->isUp == true and this->flag < this->maxflag)
            this->flag++;
        if( this->isUp == false and  this->flag > 0)
            this->flag--;
    }

    pen->setColor(this->color_flag);
    pen->setWidth(2);
    painter.setPen(*pen);

    QPainterPath path;
    int flagSize = (int)2*(double)height/3; flagSize /= maxflag;
    double x_current = x0+width/2;
    double k  = 1 - (double)this->flag/this->maxflag;
    double y_current = y0+2*(double)(k*height/3);
    path.moveTo(QPointF(x_current,y_current));
    path.lineTo(QPointF(x_current+flagSize,y_current));
    path.lineTo(QPointF(x_current+flagSize,y_current-flagSize));
    path.lineTo(QPointF(x_current,y_current-flagSize));
    path.lineTo(QPointF(x_current,y_current));
    painter.fillPath(path,QBrush(this->color_flag));
    painter.drawPath(path);

}

void BoatDialog::on_changeButton_clicked()
{
    this->isUp = !this->isUp;
    if(this->isUp)
        ui->changeButton->setText("Вниз");
    else
        ui->changeButton->setText("Вверх");
}


void BoatDialog::on_pushButton_clicked()
{
    this->settingsdialog->show();
}

void BoatDialog::takeSettings(int x_pos,int y_pos,int width,int height)
{
    if(x_pos == -1)
        x_pos = this->x_boatPos ;
    if(y_pos == -1)
        y_pos = this->height() - this->y_boatPos;
    if(width == -1)
        width = this->width_boat;
    if(height == -1)
        height = this->height_boat;

    if(proverka(x_pos,y_pos,width,height) == false){
        auto* message = new QMessageBox();
        message->setText("Неверные координаты");
        message->exec();
        delete message;
        this->settingsdialog->show();
        return;
    }

    this->x_boatPos = x_pos;
    this->y_boatPos = this->height() - y_pos;
    this->width_boat = width;
    this->height_boat = height;
}

void BoatDialog::takeBoatColor(QColor color)
{
    this->color_boat = color;
}

void BoatDialog::takeFlagColor(QColor color)
{
    this->color_flag = color;
}

bool BoatDialog::proverka(int x_pos, int y_pos, int width, int height)
{
    int x0 = width, y0 = height;
    int x1 = this->width() -width,
        y1 = this->height() - height;

    y_pos = this->height() - y_pos;
    if(((x_pos >= x0 and x_pos <= x1) or x_pos == -1)and
        ((y_pos >= y0 and y_pos <= y1) or y_pos == -1))
        return true;
    return false;
}


