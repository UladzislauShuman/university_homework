#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    center = new QPoint(this ->width()/2,this->height()/2);
    centerDialog = new CenterDialog(center);
    speedDialog = new SpeedDialog(timer,delay);
    timer  = new QTimer();
    timer->setInterval(delay);
    pen = new QPen();
    color = Qt::red;
    //menu
    connect(ui->actionSet_center,&QAction::triggered,this,&MainWindow::on_actionSetCenter_triggered);
    connect(timer,&QTimer::timeout,this,&MainWindow::timerSlot);
    timer->start();
    //other

}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::paintEvent(QPaintEvent* event)
{
    QPainter painter(this);
    painter.begin(this);

    //render
    (*pen).setColor(color);
    (*pen).setWidth(3);
    painter.setPen((*pen));
    painter.drawEllipse(*center,radius,radius);
    painter.end();
}

void MainWindow::timerSlot()
{
    if(isIncreasing){
        radius += 10;
        if(radius >= maxRadius){
            isIncreasing = false;
        }
    } else{
        radius -= 10;
        if(radius <= 20){
            isIncreasing = true;
        }
    }
    this->update();
}

void MainWindow::on_increaseSpeedButton_clicked()
{
    timer->stop();
    if(delay >= 200){
        delay = 200;
    }
    else{
        delay += 20;
    }
    timer->setInterval(delay);
    timer->start();
}


void MainWindow::on_decreaseSpeedButton_clicked()
{
    timer->stop();
    if(delay <= 20){
        delay = 20;
    }
    else{
        delay -= 20;
    }
    timer->setInterval(delay);
    timer->start();
}

void MainWindow::on_actionSetCenter_triggered()
{
    ui->centerDialog->show();
}



void MainWindow::on_colorButton_clicked()
{
    color = QColorDialog::getColor();
    this->update();
}




void MainWindow::on_setRadiusButton_clicked()
{
    //timer->stop();
    int maxRadius_ = ui->editRadius->text().toInt();
    if(maxRadius_ > 250)
    {
        auto* message = new QMessageBox();
        message->setText("bigger than 250");
        message->exec();
        delete message;
        timer->start();
        return;
    }else if(maxRadius_ < 20){
        auto* message = new QMessageBox();
        message->setText("less than 20");
        message->exec();
        delete message;
        timer->start();
        return;
    }
    maxRadius = maxRadius_;
    this->update();
    //timer->start();
}

void on_actionSetCenter_triggered(){

}

