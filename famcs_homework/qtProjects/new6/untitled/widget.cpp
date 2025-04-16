#include "widget.h"
#include "ui_widget.h"
#include <QTabBar>

Widget::Widget(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::Widget)
{
    ui->setupUi(this);

    connect(ui->trusy,&QPushButton::clicked,this,&Widget::ClikedSlot);
    connect(ui->trusySniat,&QPushButton::clicked,this,&Widget::sniatTrusy);
}

Widget::~Widget()
{
    delete ui;
}

void Widget::ClikedSlot()
{
    ui->label->setText("красивая попа?");
}

void Widget::sniatTrusy()
{
    ui->label_2->setText("у Андрея больше нет трусов");
    ui->trusySniat->setText("попался!!!");
}

