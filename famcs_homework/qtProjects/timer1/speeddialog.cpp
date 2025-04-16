#include "speeddialog.h"
#include "ui_speeddialog.h"

SpeedDialog::SpeedDialog(QTimer* timer_, int* delay_, QWidget *parent) :
    timer(timer_),
    delay(delay_),
    QDialog(parent),
    ui(new Ui::SpeedDialog)
{
    ui->setupUi(this);
}

SpeedDialog::~SpeedDialog()
{
    delete ui;
}

void SpeedDialog::on_applyButton_clicked()
{
    timer->stop();
    *delay = ui->editSpeed->text().toInt();
    timer->setInterval(*delay);
    timer->start();
}

void SpeedDialog::on_closeButton_clicked()
{
    this->close();
}

