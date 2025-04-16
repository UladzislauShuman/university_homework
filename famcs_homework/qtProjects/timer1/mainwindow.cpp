#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    center = new QPoint(this->width() / 2, this->height() / 2);
    timer = new QTimer();
    timer->setInterval(delay);
    pen = new QPen();
    color = Qt::red;

    centerDialog = new CenterDialog(center);
    speedDialog = new SpeedDialog(timer, &delay);

    // MENU
    connect(timer, &QTimer::timeout, this, &MainWindow::timerSlot);
    timer->start();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::paintEvent(QPaintEvent* event) {
    QPainter painter(this);
    painter.begin(this);

    // RENDER
    pen->setColor(color);
    pen->setWidth(3);
    painter.setPen(*pen);
    painter.drawEllipse(*center, radius, radius);
    painter.end();
}

void MainWindow::timerSlot() {
    if (isIncreasing) {
        radius += 10;
        if (radius >= maxRadius) {
            isIncreasing = false;
        }
    } else {
        radius -= 10;
        if (radius <= 20) {
            isIncreasing = true;
        }
    }
    this->update();
}

void MainWindow::on_colorButton_clicked()
{
    color = QColorDialog::getColor();
    this->update();
}
void MainWindow::on_increaseSpeedButton_clicked()
{
    timer->stop();
    if (delay >= 200) {
        delay = 200;
    } else {
        delay += 20;
    }
    timer->setInterval(delay);
    timer->start();
}

void MainWindow::on_actionSetSpeed_triggered() {
    speedDialog->show();
}

void MainWindow::on_decreaseSpeedButton_clicked()
{
    timer->stop();
    if (delay <= 20) {
        delay = 20;
    } else {
        delay -= 20;
    }
    timer->setInterval(delay);
    timer->start();
}

void MainWindow::on_actionSetCenter_triggered() {
    centerDialog->show();
}


void MainWindow::on_setRadiusButton_clicked()
{
    int maxRadius_ = ui->editRadius->text().toInt();
    if (maxRadius_ > 250) {
        auto* message = new QMessageBox();
        message->setText("Radius is too big");
        message->exec();
        delete message;
        return;
    } else if (maxRadius_ < 20) {
        auto* message = new QMessageBox();
        message->setText("Radius is too low");
        message->exec();
        delete message;
        return;
    }
    maxRadius = maxRadius_;
}

