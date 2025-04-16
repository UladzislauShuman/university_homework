#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QColor>
#include <QColorDialog>

MainWindow::MainWindow(QWidget* parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    pen.setColor(QColorConstants::Svg::violet);
    pen.setWidth(4);
    pen.setStyle(Qt::SolidLine);
    font.setPointSize(24);
    font.setBold(true);
    stackSize = 0;
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    this->update();
}

void MainWindow::paintEvent(QPaintEvent*)
{
    std::vector<int> stackVector = stack.toVector();
    QPainter painter(this);
    painter.begin(this);
    painter.setBrush(QBrush(Qt::NoBrush));
    painter.setPen(pen);
    painter.setFont(font);
    int rectX = 200, rectY = 0, rectW = 100, rectH;
    rectH = (stackSize == 0) ? 0 : (this->height() / stackSize);
    for (int i = 0; i < stackSize; i++) {
        painter.drawRect(QRect(rectX, rectY, rectW, rectH));
        painter.drawText(rectX, rectY, rectW, rectH, Qt::AlignCenter, QString::number(stackVector[i]));
        rectY += rectH;
    }
    painter.end();
}

void MainWindow::on_pushButtonPush_clicked()
{
    int value = ui->inputLine->text().toInt();
    stack.push(value);
    stackSize++;
    ui->inputLine->clear();
    this->update();
}

void MainWindow::on_pushButtonPop_clicked()
{
    if (stack.isEmpty()) {
        return;
    }
    else {
        ui->inputLine->setText(QString::number(stack.pop()));
        stackSize--;
    }
    this->update();
}
