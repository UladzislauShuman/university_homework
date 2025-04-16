#include "widget.h"
#include "ui_widget.h"

Widget::Widget(QWidget *parent): QWidget(parent), ui(new Ui::Widget)
{
    ui->setupUi(this);
    connect(ui->Masha1Button,&QPushButton::clicked,this,&Widget::ClickSlotMasha1);
    connect(ui->Masha2Button,&QPushButton::clicked,this,&Widget::ClickSlotMasha2);
    connect(ui->Masha3Button,&QPushButton::clicked,this,&Widget::ClickSlotMasha3);
    connect(ui->Masha4Button,&QPushButton::clicked,this,&Widget::ClickSlotMasha4);
    connect(ui->Masha5Button,&QPushButton::clicked,this,&Widget::ClickSlotMasha5);
    connect(ui->getTab1to2,&QPushButton::clicked,this,&Widget::ClickTab1To2);
    connect(ui->getTab2to1,&QPushButton::clicked,this,&Widget::ClickTab2To1);
}

Widget::~Widget()
{
    delete ui;
}

void Widget::ClickSlotMasha1()
{
    ui -> Masha1Label->setText("Зайчик пьёт чай");
}

void Widget::ClickSlotMasha2()
{
    ui -> Masha2Label->setText("Сердечко");
}

void Widget::ClickSlotMasha3()
{
    ui -> Masha3Label->setText("Мур-Мур-Мур");
}

void Widget::ClickSlotMasha4()
{
    ui -> Masha4Label->setText("У Маши классная попа");
}

void Widget::ClickSlotMasha5()
{
    ui -> Masha5Label->setText("Какая Милашка )))");
}





void Widget::ClickTab1To2()
{
    ui->tabWidget->setCurrentWidget(ui->tab2);
}
void Widget::ClickTab2To1()
{
    ui->tabWidget->setCurrentWidget(ui->tab1);
}
