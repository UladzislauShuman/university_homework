#include "sortdialog.h"
#include "ui_sortdialog.h"

SortDialog::SortDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::SortDialog)
{
    ui->setupUi(this);
}

SortDialog::~SortDialog()
{
    delete ui;
}

void SortDialog::slotSort(QString qstr) {
    ui->output->setText(qstr);
}

void SortDialog::on_sortButton_clicked()
{
    emit SignalSortType(ui->chooseType->currentText());
}


void SortDialog::on_closeButton_clicked()
{
    this->close();
}

