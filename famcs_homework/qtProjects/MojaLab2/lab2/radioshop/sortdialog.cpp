#include "sortdialog.h"
#include "ui_sortdialog.h"

SortDialog::SortDialog(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::SortDialog)
{
    ui->setupUi(this);
}

SortDialog::~SortDialog()
{
    delete ui;
}

void SortDialog::on_dateEndRadio_clicked(bool checked)
{
    if(checked)
        this->act = "dateEnd";
}


void SortDialog::on_doneRadio_clicked(bool checked)
{//                     отрицания, чтобы было true = возрастание
    if(checked)
        this->act = "done";
}


void SortDialog::on_typeRadio_clicked(bool checked)
{
    if(checked)
        this->act = "type";
}


void SortDialog::on_closeButton_clicked()
{

    //                        отрицания, чтобы было true = возрастание
    emit SignalSort(this->act,!(ui->checkBox->isChecked()));
    ui->checkBox->setChecked(false);
    ui->dateEndRadio->setChecked(false);
    ui->doneRadio->setChecked(false);
    ui->typeRadio->setChecked(false);
    this->close();
}

